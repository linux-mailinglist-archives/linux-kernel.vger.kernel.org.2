Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6043C3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbhJ0HiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbhJ0HiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:38:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A04C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:35:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j9so4222548lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qGjKGeSuDUaZDoV5/uNfrSoQiktZrWO+lzRzUgpx3qs=;
        b=hubUU1WknuKm0XwNFCVG5hORUOZqYI5pSnqYMcFzd607mo+Zbo5SDG3vWSGCbP5TlX
         /cNM4hzGsKHODA3ytUBfMw7NJaBAV3biCFSfVUCRecXhOIyLyG7sAoO0FGXBZMmR5tsw
         i12fYLnQknZpvg5fuB+hObbgUWMoyRdPhUeP56rV56k50yujXUZonnLO3GsU8aqatE2F
         kj6YZKYMASZQ/B8/jyS8a+fncx5Ofj24Q5y+CC1W4yHCO66xup+uoj2YkJaD+i18Pog0
         PB16jAbTpXl/pT5JpH9gjjd+EjDCEBCkZiLxJH2qoACTvWDFrzd73Vjjp98mC1tWSqkS
         HJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGjKGeSuDUaZDoV5/uNfrSoQiktZrWO+lzRzUgpx3qs=;
        b=5AJZZx1oNZZVdi25COoj/CYQi7nVopleUX7x+PjSLP7jV19nqcD1Q2uwrAj2WkzXoZ
         8eoY/EWZm8+pX8vpxSSNfn9GUjopFQQR05b7O3N4Z4uxwyGWb1ukwC/Gy+XiBdKXL2yo
         WG8hQ0v/uvty5Q4JY4oaAwH7nduiEBWSKTyIbBs5HC+SZ4bEIKbf+4aSDAR/pfRkInAe
         b3zPLUddjHimwysQCIqn+LMcSuEsPMqihZWBXTNXAsMLgD4BiWYfqnFpeXsROczPkJ0i
         JUsGYkA2sVwlIgqiDQuRoSIl/sUZWfPtuQBaPAzXTGCO3FztS675F5/2bNOrfyR6GBRR
         coTw==
X-Gm-Message-State: AOAM533mDzwCH+uEA2qRbI0CQVUR8dQgkq3x40O/7+R2OQxT33AajIfT
        x5hWiFwOPfTW3IehIMV1smw=
X-Google-Smtp-Source: ABdhPJxNV1qQ4uB3VOFu44HLiUFl+Jqwo9RzBEA61kZvsfy2ItmC7RU5ybFH+slIgTNvF1/P8mCuhA==
X-Received: by 2002:a05:6512:1304:: with SMTP id x4mr26741097lfu.591.1635320144608;
        Wed, 27 Oct 2021 00:35:44 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id g35sm957015lfv.248.2021.10.27.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:35:44 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:35:42 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH] checkpatch: Remove cvs keyword check
Message-ID: <20211027073542.qxbu236cg2wic25n@kari-VirtualBox>
References: <20211026231637.3750-1-kari.argillander@gmail.com>
 <868c29d45172a151b6a751de4ba32165cbf7a4cc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868c29d45172a151b6a751de4ba32165cbf7a4cc.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:26:21PM -0700, Joe Perches wrote:
> On Wed, 2021-10-27 at 02:16 +0300, Kari Argillander wrote:
> > Time has pass and we do not need these anymore as almost all people are
> > using git now days. Those who use cvs for kernel development probably
> > will handle cvs pretty well already so this check is not needed anymore.
> 
> I think it's a relatively harmless thing to keep.
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -4017,12 +4017,6 @@ sub process {
> >  			}
> >  		}
> >  
> > -# check for RCS/CVS revision markers
> > -		if ($rawline =~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
> 
> Looks like this would be better using
> 
> 		if ($rawline =~ /^\+.*\b\$(?:Revision|Log|Id)\$?\b/) {

As I say before I do not know much about cvs or perl regex, but I do not
get any match with your suggestion. Test strings which I have tested:

/* $Log: frob.c,v $ */
/* $Log: frob.c,v$ */
/* $Log$ */

But these can be wrong as I do not fully understand how cvs keywords
works.

> 
> > -			WARN("CVS_KEYWORD",
> > -			     "CVS style keyword markers, these will _not_ be updated\n". $herecurr);
> 
> 
