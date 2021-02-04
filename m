Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404AE30ED6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhBDHdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhBDHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:33:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1E8C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:32:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11so2546675ybl.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=oGDSex6O1pciUEDogkkInKLiGhT1AFO82LPsP2DL8RQ=;
        b=G1c7oh6v3N1YmsnHjTFVwHqPDLX72bpUizyfF0AMkJROK5rxtlLaRCtKqci8fs7Vx7
         0B20kH10SadbJYtVyKbUSm0pK1vO4oJ9wUMyj0VKXh+bqPA9k6e05klC6iWwHI+hYBg6
         sKsyJUK70AHG5nOZ2NfzUH1uDebnkJwL0QVlu35xE+oSmOZ6AzAUvT0481iq9/Ohe1GR
         seITDHrAxE2tgc1EwORFhNkW4d3yGggavxlwFvTFxSESH9qEd378rXFmem0OEX7LHzRA
         ObNHOlimlWrRzXMhFL2mBqfFhun0SfSC8snrg+qgxUJQTpUBIiz7aih+TWX+9tsqgvYA
         QF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=oGDSex6O1pciUEDogkkInKLiGhT1AFO82LPsP2DL8RQ=;
        b=S4kZfUhD5QROCO9D15ExFfzsUnJe01VrWiN0XwW9YhSexLcFSHiMrdiuVfT2YEhP4l
         xt0kIgnejjq8ruOZSJv0iObGgXPu/cc2VlmAF7RDbbrWkcOVlerbDqckIeT60IkSY7zG
         ZFEJlyTpMLKjhbOLWvUovSG++/gRgu3CtRnJ05AmNd7I+6MZWJWvQbJ+D7K0Ahfb96qJ
         RmMDvxFqpREUuNAkDTi/AUbE5qNWKpKMgr9PHgJNucafO/0H3J7iJK0HqyxLQONalsZ8
         zeLCHmoyBcFA6tXLsdu4dlXs9N09i6xrlRkxp7vaPWR+fFmAR127URavSU8dbOZnP5po
         0nEg==
X-Gm-Message-State: AOAM5337CAahPv+V7Z2i3LDSX+2XB2z/gtWMnyDdRNVawsRgGzl9ADnN
        oIFumL+1ifuN0j9kYI9W+rD2IqhiPaEC
X-Google-Smtp-Source: ABdhPJwyw6csyFSZaxcaoEkfPh66YSg3gpLd3naLgpRt8fOSZJaX5yoxUT7tIj4CC9HFqdCYdXiJD6zkBGiv
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:91f5:1565:43df:748a])
 (user=amistry job=sendgmr) by 2002:a25:7658:: with SMTP id
 r85mr10558598ybc.271.1612423973123; Wed, 03 Feb 2021 23:32:53 -0800 (PST)
Date:   Thu,  4 Feb 2021 18:32:32 +1100
Message-Id: <20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] x86: Remove HPET_EMULATE_RTC depends on RTC
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC config option was removed in commit f52ef24be21a ("rtc/alpha:
remove legacy rtc driver")

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..37775478d86f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -890,7 +890,7 @@ config HPET_TIMER
 
 config HPET_EMULATE_RTC
 	def_bool y
-	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
+	depends on HPET_TIMER && (RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
 config APB_TIMER
 	def_bool y if X86_INTEL_MID
-- 
2.30.0.365.g02bc693789-goog

