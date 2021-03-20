Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D91342D3D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCTOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:18:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87239C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:17:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so14115366eds.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CcsA1CQ5eCJW4ZA4A5udm2RGN+PSimCKRQ/qNwwrJvs=;
        b=pt/pPzh+aKkL/Vm8MGAZfggUSD9dQlUlbxH25nKf7RBg5noRztS8QyTZyBZvD/OEg4
         mZogB5wCcoEy4S62DREN5OiEltRen6qBhAkJdDgp1jJi81aTpdDBQnt2TLDXZYVZSgEa
         jcCJHcE0bgZcWBc2e43mZAp642RbxUK9r8N30MyQdxMtrnzVhpz6N2srEUTK7jCjiB6C
         rPB1aec1y4DX1eKIDOjbFCTXgFI36AuZBvYgoASQjcG2+KGn9CxadOO76pcxj4IbHTiT
         4IxoREjCsqDsoVmEBhSmzYuhA4l4ESkNo8X2CXa+qrBUJiwE3lD0tp87uf2mgzhh0Ra5
         b7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CcsA1CQ5eCJW4ZA4A5udm2RGN+PSimCKRQ/qNwwrJvs=;
        b=IgBMpmqBCb77wNDSVpftPrGnSlRupqpdwz+5RmNATfmZvvS23O4q4rCr2H+/vWUxf6
         nv3gbXp09TBsH4V9g02sAQj3mX5TNF5dH9xrpc+jjpiHrv9CQaHu+AZuWRyNK31zMcJi
         GPNu/E3FZC9acsUM7soOxwCE8qL6+RHgbDJ7bvS45WIxxXXXpcBkpJi0WyGQkq5YbzZt
         RCVCvMYbBViw9flzCZZOXRHamg6OqPPl1rLIcFF6WrX9OL6SvotUHefjJg3m2JoCiW2U
         QKIW1TdeJLeXOJxYXpIOt99U4N5UaR0vIMSpncrO22B4d4wmYDY/z0T1WSZugpFxPJ9q
         t3Hw==
X-Gm-Message-State: AOAM531cULV73nya763y3sgTQuDVqjIPPNMyGNij0dv8s8tvVjFBRV+w
        X/17OmXWNY20VtE3DttT+uiaEi0pOB+zrw==
X-Google-Smtp-Source: ABdhPJxwWt/iRQhhg3qRVUn4pwP37E47UkiBYzNKQcPx0mbRbBTDWnU34Y9Wxkyr2mXsXrEzCb6VUQ==
X-Received: by 2002:aa7:dad7:: with SMTP id x23mr2678658eds.292.1616249872308;
        Sat, 20 Mar 2021 07:17:52 -0700 (PDT)
Received: from agape.jhs ([151.46.159.47])
        by smtp.gmail.com with ESMTPSA id gq25sm5485411ejb.85.2021.03.20.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:17:51 -0700 (PDT)
Date:   Sat, 20 Mar 2021 15:17:48 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <20210320141745.GA1611@agape.jhs>
References: <20210320105424.GA3698@agape.jhs>
 <YFXVoHvk/VesFn14@kroah.com>
 <c27ae8926ccbc0f520045fea9127811f6e8fa706.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27ae8926ccbc0f520045fea9127811f6e8fa706.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 04:28:51AM -0700, Joe Perches wrote:
> On Sat, 2021-03-20 at 11:59 +0100, Greg KH wrote:
> > On Sat, Mar 20, 2021 at 11:54:24AM +0100, Fabio Aiuto wrote:
> > > Hi,
> > > 
> > > here's an issue in checkpatch.pl
> > > 
> > > $ perl script/checkpatch.pl -f drivers/staging/rtl8723bs/core/rtw_ap.c
> > > 
> > > I get three warning related to an extern declaration
> > > 
> > > WARNING: externs should be avoided in .c files
> > > #14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
> > > +extern unsigned char WMM_OUI[];
> > > --
> > > WARNING: externs should be avoided in .c files
> > > #15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
> > > +extern unsigned char WPS_OUI[];
> > > --
> > > WARNING: externs should be avoided in .c files
> > > #16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
> > > +extern unsigned char P2P_OUI[];
> > > ----------------------
> > > 
> > > but the file checked has 4 extern declaration:
> > > -----------------------------
> > > #define _RTW_AP_C_
> > > 
> > > #include <drv_types.h>
> > > #include <rtw_debug.h>
> > > #include <asm/unaligned.h>
> > > 
> > > extern unsigned char RTW_WPA_OUI[];
> > > extern unsigned char WMM_OUI[];
> > > extern unsigned char WPS_OUI[];
> > > extern unsigned char P2P_OUI[];
> > > 
> > > void init_mlme_ap_info(struct adapter *padapter)
> > > -------------------------------
> > > 
> > > If I add a ';' this way:
> > > ----------------------------
> > > #define _RTW_AP_C_
> > > 
> > > #include <drv_types.h>
> > > #include <rtw_debug.h>
> > > #include <asm/unaligned.h>
> > > ;
> > > extern unsigned char RTW_WPA_OUI[];
> > > extern unsigned char WMM_OUI[];
> > > extern unsigned char WPS_OUI[];
> > > extern unsigned char P2P_OUI[];
> > > 
> > > void init_mlme_ap_info(struct adapter *padapter)
> > > --------------------------------
> > 
> > Wait, why would you do the above?
> 
> It is rather an ugly hack.

yes it is, it was just a local and temporary one to verify that checkpatch.pl
recognizes a statement even in multiple lines, until the next ';'. In my case it has his own
drawbacks, but I will follow Greg's advice, to let checkpatch.pl doing his heavy duty:) 

> 
> > Don't try to trick a perl script that has a hard time parsing C files,
> > try to resolve the original issue here.
> > 
> > And that is that the above definitions should be in a .h file somewhere.
> > If you make that move then all should be fine.
> 
> Actually, these would seem to be better as one or multiple functions with
> local statics or even as static inlines functions in the .h file
> 
> $ git grep -w RTW_WPA_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char RTW_WPA_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        if (!memcmp(RTW_WPA_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:extern unsigned char RTW_WPA_OUI[];
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:                         if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
> 
> $ git grep -w WMM_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WMM_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WMM_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WMM_OUI, 4)) ||
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if (!memcmp(pIE->data, WMM_OUI, 4))
> drivers/staging/rtl8723bs/include/rtw_mlme_ext.h:extern unsigned char WMM_OUI[];
> 
> $ git grep -w WPS_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WPS_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WPS_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WPS_OUI, 4))) {
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                          if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {
> 
> $ git grep -w P2P_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char P2P_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(P2P_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:  if (!memcmp(frame_body + 2, P2P_OUI, 4)) {
> 
> So maybe something like the below (written in email client, maybe typos)
> 
> enum oui_type {
> 	RTW_WPA,
> 	WMM,
> 	WPS,
> 	P2P
> };
> 
> bool is_oui_type(const u8 *mem, enum oui_type type)
> {
> 	static const u8 rtw_wpa[] = {0x00, 0x50, 0xf2, 0x01};
> 	static const u8 wmm[] = {0x00, 0x50, 0xf2, 0x02};
> 	static const u8 wps[] = {0x00, 0x50, 0xf2, 0x04};
> 	static const u8 p2p[] = {0x50, 0x6F, 0x9A, 0x09};
> 
> 	const u8 *oui;
> 
> 	if (type == RTW_WPA)
> 		oui = rtw_wpa;
> 	else if (type == WMM)
> 		oui = wmm;
> 	else if (type == WPS)
> 		oui = wps;
> 	else if (type == P2P)
> 		oui = p2p;
> 	else
> 		return false;
> 
> 	return !memcmp(mem, oui, 4);
> }
> 
> so for instance the P2P uses would become
> 
> 	else if (is_oui_type(oui, P2P))
> and
> 	if (is_oui_type(frame_body + 2, P2P)) {
> 
> though I think 4 byte OUIs are just odd.
> 
> https://en.wikipedia.org/wiki/Organizationally_unique_identifier
> 
> An organizationally unique identifier (OUI) is a 24-bit number that uniquely identifies a vendor, manufacturer, or other organization.
> 
> 
> 

Thank you Joe, is the whole analisys involved with the simple task of removing them from .c files?
