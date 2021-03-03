Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14332B735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383453AbhCCKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbhCCAZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:25:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14CC061221;
        Tue,  2 Mar 2021 16:22:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u16so3742556wrt.1;
        Tue, 02 Mar 2021 16:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSX72t9mSiVVDShOFhuPdJIwlyXLwCJpyaMqc/D0w1g=;
        b=e9sMs7OGKVI0kgnPShsxFR/Re/t4foivHNL+5tD3WjkzztjMnmrJr8qcrwDKzfendx
         Kf4vJqHo82I1LwHS6nZH75NK+GdSgMmK6a/HhgwB6SPddp/0ICgkrbKbiliTau/LcPSq
         x1oZrvi2v2Q7fmnGpXhabu4PRqeyo8UfEq+4TARJuGTpB2RuZDm6URulJpks/x1YGlvR
         jINUKVXZTvRo0A0Epl2d1FzGnMqgc+pzeGxc6zgECdshLrkmcYPmDgaPUFJVWSDsN5cp
         AmI1wpi+xGZfmqKa+lR1etx5F89rGIFAv3lwPMEEsiS9s7+GM36LYLVaN2KFQ/ulzbnD
         +xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSX72t9mSiVVDShOFhuPdJIwlyXLwCJpyaMqc/D0w1g=;
        b=uFy5e3z4hHvml4Jb9QS3cs80l9P+N+mhuvexKfEbjasK4d5/tTJ72yQ1o0m81YVdQ1
         iwoSWtEwCsnT9xCm+rBfZSLRsb8G0aBFtwS96CoIT1c8IULcOe03JgWKfQB2jcXJJbRg
         Lm5H8Fc8tQlZhUmvoMpnhq6JJ318TAf0CY9LvbKe73GSaz84eZgPlmB6DBbSaGP13XRa
         5JMlDJydQtj+mzxcu/X8gO8sir3V/o9IfxSWR4mRmv2WphwT+z5qLnQd79yEJZL/BdXz
         rMMoI8QsORJviVmoGVas9DZWKgHHEntbKwXWHbaXHic8IVkkN8dBFX3EsUn/GFOrFcqo
         ACIw==
X-Gm-Message-State: AOAM530jjZj7qcnOxAA4iWxFUnnQVfKnsj9OH7AEaJr2B6wjXWG65PZ+
        pjAVKOWXVYaxoUKepLEInBE=
X-Google-Smtp-Source: ABdhPJwpEzIbfcQLh67sRjZhl/TzteAqI5j8QdU7YpOP9fz20sZB/1SyFhMvejfi8wkm7dQAtPpD7Q==
X-Received: by 2002:adf:f148:: with SMTP id y8mr23964390wro.107.1614730960262;
        Tue, 02 Mar 2021 16:22:40 -0800 (PST)
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net. [2001:470:1f1c:3e6::2])
        by smtp.gmail.com with ESMTPSA id o10sm28655767wrx.5.2021.03.02.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:39 -0800 (PST)
Date:   Wed, 3 Mar 2021 00:22:36 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Don Brace <don.brace@microchip.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Szczypek <jszczype@redhat.com>,
        Scott Benesh <scott.benesh@microchip.com>,
        Scott Teel <scott.teel@microchip.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [bisected] 5.12-rc1 hpsa regression: "scsi: hpsa: Correct dev cmds
 outstanding for retried cmds" breaks hpsa P600
Message-ID: <20210303002236.2f4ec01f@sf>
In-Reply-To: <25dfced0-88b2-b5b3-f1b6-8b8a9931bf90@physik.fu-berlin.de>
References: <20210222230519.73f3e239@sf>
        <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
        <8decdd2e-a380-9951-3ebb-2bc3e48aa1c3@physik.fu-berlin.de>
        <20210223083507.43b5a6dd@sf>
        <51cbf584-07ef-1e62-7a3b-81494a04faa6@physik.fu-berlin.de>
        <9441757f-d4bc-a5b5-5fb0-967c9aaca693@physik.fu-berlin.de>
        <20210223192743.0198d4a9@sf>
        <20210302222630.5056f243@sf>
        <25dfced0-88b2-b5b3-f1b6-8b8a9931bf90@physik.fu-berlin.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 23:31:32 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Sergei!
> 
> On 3/2/21 11:26 PM, Sergei Trofimovich wrote:
> > Gave v5.12-rc1 a try today and got a similar boot failure around
> > hpsa queue initialization, but my failure is later:
> >     https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1
> > Maybe I get different error because I flipped on most debugging
> > kernel options :)
> > 
> > Looks like 'ERROR: Invalid distance value range' while being
> > very scary are harmless. It's just a new spammy way for kernel
> > to report lack of NUMA config on the machine (no SRAT and SLIT
> > ACPI tables).
> > 
> > At least I get hpsa detected on PCI bus. But I guess it's discovered
> > configuration is very wrong as I get unaligned accesses:
> >     [   19.811570] kernel unaligned access to 0xe000000105dd8295, ip=0xa000000100b874d1
> > 
> > Bisecting now.  
> 
> Sounds good. I guess we should get Jens' fix for the signal regression
> merged as well as your two fixes for strace.

"bisected" (cheated halfway through) and verified that reverting
f749d8b7a9896bc6e5ffe104cc64345037e0b152 makes rx3600 boot again.

CCing authors who might be able to help us here.

commit f749d8b7a9896bc6e5ffe104cc64345037e0b152
Author: Don Brace <don.brace@microchip.com>
Date:   Mon Feb 15 16:26:57 2021 -0600

    scsi: hpsa: Correct dev cmds outstanding for retried cmds

    Prevent incrementing device->commands_outstanding for ioaccel command
    retries that are driver initiated.  If the command goes through the retry
    path, the device->commands_outstanding counter has already accounted for
    the number of commands outstanding to the device.  Only commands going
    through function hpsa_cmd_resolve_events decrement this counter.

     - ioaccel commands go to either HBA disks or to logical volumes comprised
       of SSDs.

    The extra increment is causing device resets to hang.

     - Resets wait for all device outstanding commands to complete before
       returning.

    Replace unused field abort_pending with retry_pending. This is a
    maintenance driver so these changes have the least impact/risk.

    Link: https://lore.kernel.org/r/161342801747.29388.13045495968308188518.stgit@brunhilda
    Tested-by: Joe Szczypek <jszczype@redhat.com>
    Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
    Reviewed-by: Scott Teel <scott.teel@microchip.com>
    Reviewed-by: Tomas Henzl <thenzl@redhat.com>
    Signed-off-by: Don Brace <don.brace@microchip.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Don, do you happen to know why this patch caused some controller init failure
for device
    14:01.0 RAID bus controller: Hewlett-Packard Company Smart Array P600
?

Boot failure: https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1
Boot success: https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1-good

The difference between the two boots is 
f749d8b7a9896bc6e5ffe104cc64345037e0b152 reverted on top of 5.12-rc1
in -good case.

Looks like hpsa controller fails to initialize in bad case (could be a race?).

-- 

  Sergei
