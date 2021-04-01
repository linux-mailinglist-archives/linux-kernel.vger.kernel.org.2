Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F3351310
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDAKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDAKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:12:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A3C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 03:12:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so2025030ejz.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lzW4BlsZetgCzXxUSanRsURtvah1swCuTO5rdJaayc=;
        b=cOGQRq6JAECo/E439aNxCpfYxchqSefixnlJyby+0LJFFl8urNEsPTi7pwj7xwpRaE
         KnO36R+PBqp+HAlC00jTY/SU74h292yR18GBGf41CMRNyMxkCd7DUYJ5urZRJ8fQUg0p
         c7XBX4s4x24Up1ARbUHJ0Qvrjvg8uzVz6yicKOCp4CW8HTiFxebe242yMWCOXKAX0y2v
         wkTWniGFaWb3YY8/gEatWHILsfpSa2JkuIJBc9m2EDz1CuKFYaFqiJJKlvBl9udIP3pP
         Qi0TI7YiCYfuoEtVc5hCsYYZ/thXxXUstpTSVUjQs7oyltNlUct70TSuAAGF4ty0rot4
         lHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lzW4BlsZetgCzXxUSanRsURtvah1swCuTO5rdJaayc=;
        b=mRaTPqQpsL/JQWBby+nC4Nb26kJ3AVrXRQvhowQMLjK2gWTQVgDoNI2/A0lHYIxcqo
         lP/LKGFKc78RJd4k1m1w37U95TGsOANAG+ft8tAPz3RkKZUg2nVb0iJScVwNDDrIHhzL
         OZ4eOYF2XtLYlwWWFoCtdoEngAnA5XrCrR7dhpAXJCmFj45amOhq1EBIU0g8PKIkpKC2
         FbMEUxsJnV2Y9uQqAzeVD/RAP1Ri2Go0wHmTjJm9cAwHCR9XU403SEyM4ljGfFDwvcYI
         nL6rHRrg/J4iBk9URrrzWNTyZ3Zmu5s/8an9+kmhd4Nc2fa6C66HGEQAQOlzGBIo08PC
         LJbw==
X-Gm-Message-State: AOAM531kNSeGzx+zVk8sY41Kvn3eArsfR56caUY7olgp3oFQIGWaOTm9
        0RMko4mprO6hDwwNAzg0eIo=
X-Google-Smtp-Source: ABdhPJxRxpCLy0cFre89eHn7+chccPiKXzBr53GO9fe1kmkoQFwYzKw0cP22uRUjtQBwyKbINUQVAw==
X-Received: by 2002:a17:906:4c56:: with SMTP id d22mr8606019ejw.426.1617271959817;
        Thu, 01 Apr 2021 03:12:39 -0700 (PDT)
Received: from agape.jhs ([5.171.72.75])
        by smtp.gmail.com with ESMTPSA id j14sm3278007edr.97.2021.04.01.03.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 03:12:39 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:12:36 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 49/49] staging: rtl8723bs: remove obsolete macro
Message-ID: <20210401101236.GB32563@agape.jhs>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <1c7cdfcf488e5dc5bc5c3c29733b0d53caee71fb.1617268327.git.fabioaiuto83@gmail.com>
 <44730b7154cba578c5c342f1919d0937009985fa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44730b7154cba578c5c342f1919d0937009985fa.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:57:36AM -0700, Joe Perches wrote:
> On Thu, 2021-04-01 at 11:21 +0200, Fabio Aiuto wrote:
> > remove obsolete macro RT_TRACE
> []
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> []
> > -#ifdef DEBUG_RTL871X
> > -
> > -#if	defined(_dbgdump) && defined(_MODULE_DEFINE_)
> > -
> > -	#undef RT_TRACE
> > -	#define RT_TRACE(_Comp, _Level, Fmt)\
> > -	do {\
> > -		if ((_Comp & GlobalDebugComponents) && (_Level <= GlobalDebugLevel)) {\
> > -			_dbgdump("%s [0x%08x,%d]", DRIVER_PREFIX, (unsigned int)_Comp, _Level);\
> > -			_dbgdump Fmt;\
> > -		} \
> > -	} while (0)
> > -
> > -#endif /* defined(_dbgdump) && defined(_MODULE_DEFINE_) */
> > -#endif /* DEBUG_RTL871X */
> 
> Maybe remove all of these too
> 
> $ git grep DEBUG_RTL871X
> drivers/staging/rtl8723bs/core/rtw_debug.c:#ifdef DEBUG_RTL871X
> drivers/staging/rtl8723bs/core/rtw_debug.c:#endif /* DEBUG_RTL871X */
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:#ifdef DEBUG_RTL871X
> drivers/staging/rtl8723bs/include/autoconf.h:/*#define DEBUG_RTL871X */
> drivers/staging/rtl8723bs/include/rtw_debug.h:#ifdef DEBUG_RTL871X
> drivers/staging/rtl8723bs/include/rtw_debug.h:#endif /* DEBUG_RTL871X */
> 
> 

there are a lot of things to remove, I thought to do it in next patchsets

maybe other obsolete tracing macros are involved...


