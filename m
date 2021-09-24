Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBC4171E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbhIXMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbhIXMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:33:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75CAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:31:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v18so185929edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85DTZ6nXXMkHYkD5g7M203wU5w8Lip8La1SQcqg9VRc=;
        b=YgghRzcLrkepjQSruC27d5zNQZfAbRRpHMChS7y91U6oq5UrLYUcByLjFTHGiL/e9/
         I2gQ07YYtimYCVW0HsaAf7d9b+uzOeFmxaxRz1U1o70nLfjfEuGnNLBdYo344q7z3OP0
         MaIi8xcMTbHNF+fD1JfBXLDZyvsM94fFaDthv2p7w9ydr5AM6bSmy56yAkSBycN6t9A2
         KHBj6xTRetB18QCtfQJ7yzSOQdTEOMREBy0XbgU0nxyTzCdbLHAOh0deIPlqh0Nf/oVE
         5xSZLQyGMMzNC13Cl944ylqaMOdeXYsgRPYc64ncoYi5/5Mv/MIRqsmSTuGJ1qHabw6i
         tyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85DTZ6nXXMkHYkD5g7M203wU5w8Lip8La1SQcqg9VRc=;
        b=cm0GX8dyRomY6y87VU1M1iEDcPPM6QiHekYx9wKLzTEoj5xtvN10vZspgvR5823/NV
         OnmgH5TsTzvuFt8mQi+24ttGM2KNLtPx0Ub8Av9frO/46Z9Ktny4UMn0YsYeLbKIwtwp
         bVBznAb5Q534u07OokX/gbax8dxVpj1kZGWPfbp+1gkPqCLbOZql8fX1JyNUd2OlEY4X
         KRWuPiP2aCixekssnC14Th3G3IlT7M4S963IPRRRAsP/ZvDfbJi0G7L+CPLXFeT47UbO
         1sTccfUpYi7MATx3BhUIVHO05JSxEwuw7QLFbvYibdS43yLqymVxyUYpkXw1N+1G/VP0
         k5jg==
X-Gm-Message-State: AOAM531qT8VfYJ1JTCLjqV2V7sZbwyFVW4xfJlLcFpDmOKlxMU3DAwz4
        2sdEQV5+NeU74vs0A9SG0IM=
X-Google-Smtp-Source: ABdhPJw9/8k0U034bI3MuFTZcWpN6NQuC+QQ5WWCkSTCnXpB2R30waScE0//PnjlaEzKbITiCBR+bA==
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr10946965ejt.98.1632486711114;
        Fri, 24 Sep 2021 05:31:51 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id d11sm4901501ejw.8.2021.09.24.05.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:31:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 00/16] staging: r8188eu: shorten and simplify calls chains
Date:   Fri, 24 Sep 2021 14:31:29 +0200
Message-Id: <20210924123129.3951-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--- Preface ---

This is v10 of "shorten and simplify calls chain". The 14 (v7) + 2 (v8) 
patches have already been applied to staging-testing, so we have been 
requested to reset the numbering of the remaining patches to 01/16, while 
discarding from v9 the above-mentioned 16 patches (otherwise we would
have submitted a series containing 32 patches, that is 1 patch less than
v8 because it has been dropped by us in what we considered it
unnecessary - it was about fixing a misspelled word in a comment).

The following commit message is provided as it was in v8, both for the
purpose of presenting the whole picture to Maintainers, Reviewers, and to
anybody else who may be interested in knowing the entire design and the
evolution since v1 to the current v10.

--- Commit message ---

io_ops abstraction is useless in this driver, since there is only one ops
registration. Without io_ops we can get rid of indirect calls mess and
shorten the calls chain.

Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32 into the new
usb_read(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_read() and use in it the new
usb_control_msg_recv() API of USB Core.

Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
For this purpose unify the four usb_write8/16/32/N() into the new
usb_write(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_write() and use in it the new
usb_control_msg_send() API of USB Core.

The code with the modifications was thoroughly tested by Pavel Skripkin
using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS] and by Fabio M.
De Francesco using a ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].

--- Changelog ---

v9-v10:
	- 1-15: 
		No changes;
	- 16:
		Fix a bug inadvertently introduced in v8.

v8->v9 (after numbering reset in v8):
	- 1-7,9,10,12:
		Clean-up patches with no significant changes in code.
		We've applied some fixes required by Greg Kroah-Hartman:
		(1) rename of an argument (intfhdl => intf), (2)
		explanation of why "!io_buf" test is redundant and
		unnecessary, (3) deletion of comments for single line
		'if' statements, (4) fix of a coding style issue by
		removing unnecessary braces;
	- 8,11:
		Add more detailed motivation in support of changing the
		type of two variables, one in rtw_read16() and the other
		in rtw_write16();
	- 13,14:
		No significant changes in the code; just rebase on top of
		minor changes introduced by the patches 1-12;
	- 15,16:
		No changes.

v7->v8 (old numbering):
        - 1-14:
                Patches applied to staging-testing, so they are dropped
                from the current v8;

        - 15-19:
                Split into 19 patches. Numbering reset to 01. After this
                reset, 15-19/19 become 01-19/19 (so we have a total of 33
                patches in this series.

v7->v8 (new numbering for the old 15-19/19):
        - 1-15:
                Old 15/19 and 16/19 are split into 15 patches (as it is
                required by Greg Kroah-Hartman) in order to make them
                more easily reviewable and for checking that the logic
                is not broken; no significant changes to the resulting
                code;
        - 16-17:
                Old 17/19 and 18/19 become 16/19 and 17/19: There are
                no significant changes to the code, with the sole
                exception of moving the acquiring of a mutex before
                the test for "bSurpriseRemoved" being 'true';
        - 18-19:
                Old 19/19 is split into new 18/19 and 19/19. The changes
                are split into a first patch that remove a shared buffer
                and a second that remove the mutex protecting the receiving
                (in usb_read()) and sending (in usb_write()) of the
                USB control messages.

v6->v7:
        - 1-14:
                Add Dan Carpenter's "Reviewed-by" tag. No code changes;
        - 15:
                Add a list of clean-up changes to the commit messages
                and restore an empty line inadvertently deleted in a
                previous version;
        - 16:
                Add a list of clean-up changes to the commit messages;
        - 17-18:
                No changes;
        - 19:
                Delete an unnecessary test.

v5->v6:
        - 1-14:
                Minimal changes to patch subjects to achieve consistent
                style;
        - 15:
                Fix a mistake in the checks of values returned by
                usb_control_msg();
        - 16-19:
                No changes.

v4->v5:
        - 1-14:
                No changes;
        - 15-16:
                Fix minor formatting issues and use "Reverse Xmas Tree" style,
	        according to suggestions by David Laight and Dan Carpenter;
        - 17-18:
                Pavel Skripkin found logical errors in the checks of the
                values returned by usb_control_msg_{recv,send}(), so fix them;
                Dan Carpenter suggested to do error handling before success
                handling, so change the code accordingly;
        - 19:
                Add this patch in order to get rid of the shared buffer in
                usb_read() and usb_write() and remove this field from struct
                "dvobj_priv".

v3->v4:
        - 1-14:
                Split a patch into fourteen;
        - 15-16:
                Add these patches for clean-ups of the code that is going to be
                reused in 17-18/18;
        - 17-18:
                Make some changes according to a first review of Greg
                Kroah-Hartman; furthermore, remove the unnecessary while loop
                and a couple of if' test; handle the errors returned by
                usb_control_msg_recv().

v2->v3:
        - 1-2:
                No changes;
        - 3:
                Fix the version number of the patch.

v1->v2:
        - 1-2:
                No changes;
        - 3:
                Replace parameter REALTEK_USB_VENQT_READ with REALTEK_USB_VENQT_WRITE
                in usb_control_msg_send().

--- List of links to previous versions of the cover letters ---

v1: https://lore.kernel.org/lkml/20210904150447.14659-1-fmdefrancesco@gmail.com/
v2: https://lore.kernel.org/lkml/20210904212719.11426-1-fmdefrancesco@gmail.com/
v3: https://lore.kernel.org/lkml/20210904220048.12822-1-fmdefrancesco@gmail.com/
v4: https://lore.kernel.org/lkml/20210913181002.16651-1-fmdefrancesco@gmail.com/
v5: https://lore.kernel.org/lkml/20210915124149.27543-1-fmdefrancesco@gmail.com/
v6: https://lore.kernel.org/lkml/20210915211103.18001-1-fmdefrancesco@gmail.com/
v7: https://lore.kernel.org/lkml/20210917071837.10926-1-fmdefrancesco@gmail.com/
v8: https://lore.kernel.org/lkml/20210919235356.4151-1-fmdefrancesco@gmail.com/
v9: https://lore.kernel.org/lkml/20210921181834.29677-1-fmdefrancesco@gmail.com/

--- List of patches not yet applied, authorship, diff stats ---

Fabio M. De Francesco (14):
  staging: r8188eu: clean up symbols in usbctrl_vendorreq()
  staging: r8188eu: reorder declarations in usbctrl_vendorreq()
  staging: r8188eu: remove unnecessary test in usbctrl_vendorreq()
  staging: r8188eu: reorder comments in usbctrl_vendorreq()
  staging: r8188eu: remove a comment from usbctrl_vendorreq()
  staging: r8188eu: rename symbols in rtw_read*() and rtw_write*()
  staging: r8188eu: remove casts from rtw_{read,write}*()
  staging: r8188eu: change the type of a variable in rtw_write16()
  staging: r8188eu: remove an buffer from rtw_writeN()
  staging: r8188eu: remove a bitwise AND from rtw_writeN()
  staging: r8188eu: change the type of a variable in rtw_read16()
  staging: r8188eu: Remove a test from usbctrl_vendorreq()
  staging: r8188eu: call new usb_read() from rtw_read{8,16,32}()
  staging: r8188eu: call new usb_write() from rtw_write{8,16,32,N}()

Pavel Skripkin (2):
  staging: r8188eu: remove shared buffer for USB requests
  staging: r8188eu: remove usb_vendor_req_mutex

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 213 ++++++++++----------
 drivers/staging/r8188eu/include/drv_types.h |   3 -
 drivers/staging/r8188eu/os_dep/usb_intf.c   |  36 ----
 3 files changed, 107 insertions(+), 145 deletions(-)

--
2.33.0

