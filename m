Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0873FCD07
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhHaSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbhHaSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:44:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:43:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s12so496900ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NW9pRq8jRsFXrS7VIuuj8MsRMAjJAt9fcukvZZ1utbk=;
        b=qGTUnhWYuebBX3IGzbOaygL1xjMkqiWXbBXvIrffCDCIaPvnilBs+b25u+o6hcJBPY
         dXz+Nc99HbBSHD+hu5SXw0UX5Mcu9+qF5gmrlD/ytXM8rNFeZEHTizA24U9G1/W5g/S7
         Rbg9ZEqnBM0+KnHBEfTUmkd7ECpdG89QXSDaOlr5JpaiOTDtr+tsCLiOF9XvMVojuJUq
         d/3hJNEFaSMKwMfiCTkw49N15AeGDnWPa200Qs4Xltkvb1S2nXZgw3jwZ9EQTfPTJmuQ
         3pWpVjlWpITq5l/yx4bkgG3ksutA1pIFcJMgvzAcEPyMqjesl1pSONAqmjiF8Z50UKPd
         0+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NW9pRq8jRsFXrS7VIuuj8MsRMAjJAt9fcukvZZ1utbk=;
        b=bn/w9RLG66aDS4f/B7c2xT789SiGe97WOpYVNj1ioCb/d0mWmNt6gnwhiI6qM0IJQU
         kHBl1QoMiZPioGvT4UPDTQSQiQjjrK9s1Mxgd/Ap3fsgNnlJuFCH4QdPmVOcKu1cePvv
         O5ECkACos2lGH0+33aCnnnGy1+F4HQ91zELHgvE3LpvD7dKKE/bhHgG6RPPEKaPnHIbB
         30A5QlSorGz5mzNtHkA4JPQZL40DI5PEfD6VHvnAUvRGcpGtuIJB4yYz3gGsUf/+hCcX
         WQRp4chQdHM7H4CwVmCJExFtrYLGtIFdBwkoIicQ0lBW1wW0KFOd+Ej23RuvyVB7+Sky
         mRYg==
X-Gm-Message-State: AOAM531mBJuOPaX8S0az4hsXhwye95opZJPzZZZqaOJlV+YptcIJs86C
        zb7HVGVPo2vxWZ5VqbY8v7o=
X-Google-Smtp-Source: ABdhPJxWyxgfJO0cp+neOqvUDljek+zgtF/qalNTd8pdqmjvdMtxwkTfHCo7cBRE3sayaDczPvS5jQ==
X-Received: by 2002:a2e:a4c2:: with SMTP id p2mr26173356ljm.316.1630435396683;
        Tue, 31 Aug 2021 11:43:16 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id n3sm1813376lft.63.2021.08.31.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:43:16 -0700 (PDT)
Date:   Tue, 31 Aug 2021 21:43:14 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] fs/ntfs3: Change right headers to lznt.c
Message-ID: <20210831184314.a7pjzimgksilyi7d@kari-VirtualBox>
References: <20210831141434.975175-7-kari.argillander@gmail.com>
 <202109010143.J3Eeb1Nw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109010143.J3Eeb1Nw-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:54:23AM +0800, kernel test robot wrote:
> Thank you for the patch! Yet something to improve:

Patch series should have be 8 patch long. Sorry for mistake. Good thing
robot noticed.  Will send v2 tomorrow night.

> [auto build test ERROR on next-20210831]
> [cannot apply to linus/master v5.14 v5.14-rc7 v5.14-rc6 v5.14]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Will do now on.  I did not know about this.

Still if someone wants to check why this report was made and what should
have be patch 1/8.  Here it is:

[PATCH 1/8] fs/ntfs3. Add forward declarations for structs to debug.h

Add forward declarations for structs so that we can include this file
without warnings even without linux/fs.h

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/debug.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
index 31120569a87b..53ef7489c75f 100644
--- a/fs/ntfs3/debug.h
+++ b/fs/ntfs3/debug.h
@@ -11,6 +11,9 @@
 #ifndef _LINUX_NTFS3_DEBUG_H
 #define _LINUX_NTFS3_DEBUG_H
 
+struct super_block;
+struct inode;
+
 #ifndef Add2Ptr
 #define Add2Ptr(P, I)		((void *)((u8 *)(P) + (I)))
 #define PtrOffset(B, O)		((size_t)((size_t)(O) - (size_t)(B)))
-- 
2.25.1
