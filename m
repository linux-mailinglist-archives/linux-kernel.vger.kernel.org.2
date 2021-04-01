Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF83512DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhDAJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:58:08 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:46378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233553AbhDAJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:57:41 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D6D721821939A;
        Thu,  1 Apr 2021 09:57:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id E24EE1E04DB;
        Thu,  1 Apr 2021 09:57:38 +0000 (UTC)
Message-ID: <44730b7154cba578c5c342f1919d0937009985fa.camel@perches.com>
Subject: Re: [PATCH 49/49] staging: rtl8723bs: remove obsolete macro
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 02:57:36 -0700
In-Reply-To: <1c7cdfcf488e5dc5bc5c3c29733b0d53caee71fb.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
         <1c7cdfcf488e5dc5bc5c3c29733b0d53caee71fb.1617268327.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E24EE1E04DB
X-Spam-Status: No, score=0.10
X-Stat-Signature: i16kjuuxdf6pyfcafokbc7k1wb5bhuyk
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1pH22N4+o4Qcx1qZTrXkESthNYQEGMPA=
X-HE-Tag: 1617271058-622136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-01 at 11:21 +0200, Fabio Aiuto wrote:
> remove obsolete macro RT_TRACE
[]
> diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
[]
> -#ifdef DEBUG_RTL871X
> -
> -#if	defined(_dbgdump) && defined(_MODULE_DEFINE_)
> -
> -	#undef RT_TRACE
> -	#define RT_TRACE(_Comp, _Level, Fmt)\
> -	do {\
> -		if ((_Comp & GlobalDebugComponents) && (_Level <= GlobalDebugLevel)) {\
> -			_dbgdump("%s [0x%08x,%d]", DRIVER_PREFIX, (unsigned int)_Comp, _Level);\
> -			_dbgdump Fmt;\
> -		} \
> -	} while (0)
> -
> -#endif /* defined(_dbgdump) && defined(_MODULE_DEFINE_) */
> -#endif /* DEBUG_RTL871X */

Maybe remove all of these too

$ git grep DEBUG_RTL871X
drivers/staging/rtl8723bs/core/rtw_debug.c:#ifdef DEBUG_RTL871X
drivers/staging/rtl8723bs/core/rtw_debug.c:#endif /* DEBUG_RTL871X */
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
drivers/staging/rtl8723bs/include/autoconf.h:/*#define DEBUG_RTL871X */
drivers/staging/rtl8723bs/include/rtw_debug.h:#ifdef DEBUG_RTL871X
drivers/staging/rtl8723bs/include/rtw_debug.h:#endif /* DEBUG_RTL871X */


