Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D9342C28
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCTL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:29:17 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:52408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229510AbhCTL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:28:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0992F182CED28;
        Sat, 20 Mar 2021 11:28:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:599:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:1801:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4184:4250:4321:4605:5007:6119:6121:7652:7903:7904:8985:9025:10004:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12683:12740:12760:12895:13019:13439:13972:14659:21060:21080:21324:21433:21451:21611:21627:21660:21819:21990:30022:30034:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: desk59_340da1527757
X-Filterd-Recvd-Size: 6293
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Mar 2021 11:28:53 +0000 (UTC)
Message-ID: <c27ae8926ccbc0f520045fea9127811f6e8fa706.camel@perches.com>
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-kernel@vger.kernel.org, apw@canonical.com
Date:   Sat, 20 Mar 2021 04:28:51 -0700
In-Reply-To: <YFXVoHvk/VesFn14@kroah.com>
References: <20210320105424.GA3698@agape.jhs> <YFXVoHvk/VesFn14@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-03-20 at 11:59 +0100, Greg KH wrote:
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

It is rather an ugly hack.

> Don't try to trick a perl script that has a hard time parsing C files,
> try to resolve the original issue here.
> 
> And that is that the above definitions should be in a .h file somewhere.
> If you make that move then all should be fine.

Actually, these would seem to be better as one or multiple functions with
local statics or even as static inlines functions in the .h file

$ git grep -w RTW_WPA_OUI drivers/staging/rtl8723bs/core
drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char RTW_WPA_OUI[];
drivers/staging/rtl8723bs/core/rtw_ap.c:        if (!memcmp(RTW_WPA_OUI, oui, 4))
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:extern unsigned char RTW_WPA_OUI[];
drivers/staging/rtl8723bs/core/rtw_wlan_util.c:                         if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))

$ git grep -w WMM_OUI drivers/staging/rtl8723bs/core
drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WMM_OUI[];
drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WMM_OUI, oui, 4))
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WMM_OUI, 4)) ||
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if (!memcmp(pIE->data, WMM_OUI, 4))
drivers/staging/rtl8723bs/include/rtw_mlme_ext.h:extern unsigned char WMM_OUI[];

$ git grep -w WPS_OUI drivers/staging/rtl8723bs/core
drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WPS_OUI[];
drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WPS_OUI, oui, 4))
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WPS_OUI, 4))) {
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                          if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {

$ git grep -w P2P_OUI drivers/staging/rtl8723bs/core
drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char P2P_OUI[];
drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(P2P_OUI, oui, 4))
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:  if (!memcmp(frame_body + 2, P2P_OUI, 4)) {

So maybe something like the below (written in email client, maybe typos)

enum oui_type {
	RTW_WPA,
	WMM,
	WPS,
	P2P
};

bool is_oui_type(const u8 *mem, enum oui_type type)
{
	static const u8 rtw_wpa[] = {0x00, 0x50, 0xf2, 0x01};
	static const u8 wmm[] = {0x00, 0x50, 0xf2, 0x02};
	static const u8 wps[] = {0x00, 0x50, 0xf2, 0x04};
	static const u8 p2p[] = {0x50, 0x6F, 0x9A, 0x09};

	const u8 *oui;

	if (type == RTW_WPA)
		oui = rtw_wpa;
	else if (type == WMM)
		oui = wmm;
	else if (type == WPS)
		oui = wps;
	else if (type == P2P)
		oui = p2p;
	else
		return false;

	return !memcmp(mem, oui, 4);
}

so for instance the P2P uses would become

	else if (is_oui_type(oui, P2P))
and
	if (is_oui_type(frame_body + 2, P2P)) {

though I think 4 byte OUIs are just odd.

https://en.wikipedia.org/wiki/Organizationally_unique_identifier

An organizationally unique identifier (OUI) is a 24-bit number that uniquely identifies a vendor, manufacturer, or other organization.



