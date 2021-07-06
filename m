Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABC3BD97C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhGFPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232443AbhGFPJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70F0661C21;
        Tue,  6 Jul 2021 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625584034;
        bh=OaOtGlYd/ajyQ9/+XQVhEEAgkcRDMXj2QiJgTH5ai5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nq1KVNwHS1Rz/rXhLOhklUOzoOJm++F158VpelOJG5XH1XI3paCdgzHR924eb5+77
         kgBMLUVgXVmIRcINY9bE90fZ40oPOXVQLXQVGeEf9xUV1YdQFykFNMf+sE3Mt45JQJ
         8j2qFvF3wtuZEvtcNkwujKAdncGaZSGsQOyVrwJZwPuHnUGB+GtDJ8BDgeKp3xlI64
         PVPBlJ3yXjN9q9O2YnIDO7Xz6q7vasHHYIclHkK7MzzDNcfr3A56P2sn+CyMZyPOPH
         swNGd8ZBH0E5pSAMo5jeZRR2V3lPOx+HzX8k0EmuYkkFtGmryNkl9O+5BX1cmaWYNZ
         kO+47xPFVkVrA==
Date:   Tue, 6 Jul 2021 08:07:11 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210706150711.GA241231@dhcp-10-100-145-180.wdc.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
 <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705104208.GA14891@lst.de>
 <BLAPR08MB690003D5D175FC784DE844F8B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
 <20210705115349.GA20266@lst.de>
 <20210705130456.GA239714@dhcp-10-100-145-180.wdc.com>
 <BLAPR08MB690035C831CF24DE356DEF6FB81B9@BLAPR08MB6900.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR08MB690035C831CF24DE356DEF6FB81B9@BLAPR08MB6900.namprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 08:14:45AM +0000, Shivamurthy Shastri (sshivamurthy) wrote:
> > Is it the device that wants an abrupt shutdown or the platform? If the
> > platform's power is running on limited back-up supply, and could inform
> > the kernel's power management subsystem of this, then a driver could use
> > that to determine if the quick shutdown is appropriate.
> 
> Yes, the platform is running on limited back-up supply. In this case, abrupt shutdown
> option will help to achieve shutdown with relatively low back-up requirements.
> 
> Please let me know if you want to include the abrupt shutdown as part of 
> 
> static const struct dev_pm_ops nvme_dev_pm_ops = {
> 	.suspend	= nvme_suspend,
>                .....

Are you suggesting creating a new pm callback just for this? I don't
think that's necessary.

I was considering just adding a bit to the pm_suspend_global_flags,
something like the patch below. You just have to fill in the platform
specific parts to set the flag.

---
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..f43c0b2313d0 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -210,9 +210,10 @@ extern int suspend_valid_only_mem(suspend_state_t state);
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
-#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
-#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
+#define PM_SUSPEND_FLAG_FW_SUSPEND		BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME		BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM		BIT(2)
+#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -234,6 +235,11 @@ static inline void pm_set_suspend_no_platform(void)
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
 }
 
+static inline void pm_set_power_loss_imminent(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -291,6 +297,21 @@ static inline bool pm_suspend_no_platform(void)
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
 }
 
+/**
+ * pm_power_loss_imminent - Check if platform is running on limited backup
+ * 			    power source
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if power loss may be imminent due to platform running on
+ * limited backup supply. If set during a shutdown, drivers should use any
+ * available shortcuts to prepare their device for abrupt power loss.
+ */
+static inline bool pm_power_loss_imminent(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
--
