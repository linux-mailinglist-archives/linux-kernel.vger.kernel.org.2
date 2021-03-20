Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6B342D73
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTOt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCTOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:49:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14614C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:49:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y6so14198492eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAGXrswmnOnUdwDiOLfJrJeP7ZOTl4An3IJeyKNgZRE=;
        b=pH89CaHHrbc4iGJ9YgebaSNzaaZHuMtHVo3kHRSFqMsTem4cqOAC7rNakAdkmc0Jm0
         RBxRPRR9fUQsUW8Rqs6ziNpmXSJZLN5n++Sv0YGYbpje04roBEN3CxtqYjObP9YG5yHA
         xCIxCXiKoe8rMGf5Qc6n+kCCu5IuK/+kM84q3hiK23mR/cNU37hHwcwu4KFpX9QqWhy4
         lYZrMNrA6ihm9LE3bDWxxPxDap/69KLdqrE05gZkhxStx3RBF9jV9+19Nc4cvQl+D+jE
         73OlBxSIWnC+RPHXx3hKc92Vc/qmGaMcdCulG6hZfUfuv+OlrjBTsriqCg1JURKLWflS
         tejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAGXrswmnOnUdwDiOLfJrJeP7ZOTl4An3IJeyKNgZRE=;
        b=tSJzVYXJH20AXbB3QeGHBCx+pMHb0B4Ab3/cosiGGH7IVAao/o4/+sGKPWqSAXOVlQ
         QYxSSfeaUVSm6yNlxiYDz8qh1u8qKPyfxfhpGCah5rkLjUK5AXyHTtEHzdN1kJyDGcWA
         BpoEj9rgFL3Aq2J3zmQ+YlkkuKSJPhpnD1mgucquhn6F584GuHG6ac+EJ1EG+Eb1gTuL
         urwfawPxhD04x5XIs9xQ6FvHflqWn+iBNQvGxu9j35hjtzw5TNM9v24ywXE0yYnddRQn
         iUPMbP7GgxMIAjOWvMGGMvDVxxma/MbCHsYESFrpI42y1LNudmH7T2rHP3sVrxiDVJxb
         3oBw==
X-Gm-Message-State: AOAM530pd47YM+wezsU8+ie2CReG2q/lY4PXHbxGtPw6V6ugcS/8uAfw
        ajSds7S9Oxx3QuEovWBjcjM=
X-Google-Smtp-Source: ABdhPJzvt0bNLA0/1kGs9kPrTPcdqd50QWCiOXtOpa+LQ/XLRcC2wMa9En+KTHVviLCgSyODunxKeA==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr15817626edy.225.1616251758697;
        Sat, 20 Mar 2021 07:49:18 -0700 (PDT)
Received: from agape.jhs ([151.46.159.47])
        by smtp.gmail.com with ESMTPSA id r25sm5791860edv.78.2021.03.20.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:49:18 -0700 (PDT)
Date:   Sat, 20 Mar 2021 15:49:12 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, joe@perches.com,
        apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <20210320144911.GA2999@agape.jhs>
References: <20210320105424.GA3698@agape.jhs>
 <YFXVoHvk/VesFn14@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFXVoHvk/VesFn14@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 11:59:44AM +0100, Greg KH wrote:
> On Sat, Mar 20, 2021 at 11:54:24AM +0100, Fabio Aiuto wrote:
> > Hi,
> > 
> > here's an issue in checkpatch.pl
> > 
> > $ perl script/checkpatch.pl -f drivers/staging/rtl8723bs/core/rtw_ap.c
> > 
> > I get three warning related to an extern declaration
> > 
> > WARNING: externs should be avoided in .c files
> > #14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
> > +extern unsigned char WMM_OUI[];
> > --
> > WARNING: externs should be avoided in .c files
> > #15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
> > +extern unsigned char WPS_OUI[];
> > --
> > WARNING: externs should be avoided in .c files
> > #16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
> > +extern unsigned char P2P_OUI[];
> > ----------------------
> > 
> > but the file checked has 4 extern declaration:
> > -----------------------------
> > #define _RTW_AP_C_
> > 
> > #include <drv_types.h>
> > #include <rtw_debug.h>
> > #include <asm/unaligned.h>
> > 
> > extern unsigned char RTW_WPA_OUI[];
> > extern unsigned char WMM_OUI[];
> > extern unsigned char WPS_OUI[];
> > extern unsigned char P2P_OUI[];
> > 
> > void init_mlme_ap_info(struct adapter *padapter)
> > -------------------------------
> > 
> > If I add a ';' this way:
> > ----------------------------
> > #define _RTW_AP_C_
> > 
> > #include <drv_types.h>
> > #include <rtw_debug.h>
> > #include <asm/unaligned.h>
> > ;
> > extern unsigned char RTW_WPA_OUI[];
> > extern unsigned char WMM_OUI[];
> > extern unsigned char WPS_OUI[];
> > extern unsigned char P2P_OUI[];
> > 
> > void init_mlme_ap_info(struct adapter *padapter)
> > --------------------------------
> 
> Wait, why would you do the above?
> 
> Don't try to trick a perl script that has a hard time parsing C files,
> try to resolve the original issue here.
> 
> And that is that the above definitions should be in a .h file somewhere.
> If you make that move then all should be fine.
> 
> thanks,
> 
> greg k-h

that's another issue

WARNING: externs should be avoided in .c files
#35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
+bool

CHECK: Lines should not end with a '('
#36: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:36:
---

but that's what I see in line 35


#define REG_EFUSE_CTRL		0x0030
#define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */

bool<--------------------------------- line 35
Efuse_Read1ByteFromFakeContent(
	struct adapter *padapter,
	u16 	Offset,
	u8 *Value);
bool
Efuse_Read1ByteFromFakeContent(
	struct adapter *padapter,
	
another one...

WARNING: externs should be avoided in .c files
#40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
+u8 rtw_do_join(struct adapter *padapter); <-------- do I miss 
						something about extern keyword?

CHECK: Unnecessary parentheses around padapter->mlmepriv
#45: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:45:

thank you,

fabio
