Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C23DD383
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhHBKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233116AbhHBKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627898563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NM08fXabNvmt0MgO2S2t0sveZGR/pF6l0w48hb168co=;
        b=XuF/pCrD1v5i/fXGeiN+BO24VCrUilhq5AE+c12VOA3ngj1MEcUHs7rGRtWnP3d9wK+N9v
        Nb0uZVedo5IO+d3g6BqS54+dwtqsrxVN7HH+z2NCxA2Xw/mIhzFw+Hhhp/vGemyN3VoaJy
        fDtbGp+fbAiQr2k7JLomfzdYMRwmSw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-SM6eZi-GOiuKfOb6kzJTrQ-1; Mon, 02 Aug 2021 06:02:42 -0400
X-MC-Unique: SM6eZi-GOiuKfOb6kzJTrQ-1
Received: by mail-wr1-f72.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so6229753wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NM08fXabNvmt0MgO2S2t0sveZGR/pF6l0w48hb168co=;
        b=LAL69TklryQ+S/s/ElLZKXGyJQV73H1YaDJX5h1vs8uAcVZt5ItQAfKtIgqdLvz623
         +Uxs2bgTn9av7AVLr4drfLvmC8xRdCJ+hMq2HLoT2JTOEqUJfWR4c/ItFgCS9EY+r0S7
         9SVIV8N30hKCdxOQct4R8CDnhSLpAPVG+n9RN0oVtiLUGrzzXFP01EA27Gz9ng9968rP
         7JHKt53+bVG29Zlk5Ese/5yDE7NLb81Y9EenL8R0jW9aWvEtHxk4x0R0IIGtU9IEYzBW
         g5irZX4cTL9zzqvqqgtFHUnb47TPbUzzI6WQryVbW6Vbaf2EtKwc+OMh9J7hd96//7Yg
         ELsw==
X-Gm-Message-State: AOAM532HuJbh7fowRWrO7egUOGoionS7eVaVXVwMJw+f/Dp3cF5rWQck
        4xI1VgO6+3m0j7s2kg4qbgsBuP5PxgedMfPdQHa5VTH8n7zxKTsOM0WnvPlDRXOv25QWh7kMQCl
        GyP+9uTguBj7xQfsKI99bGrf0
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr15891720wmf.21.1627898561019;
        Mon, 02 Aug 2021 03:02:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9wvwDkYQc8eAcjmUTrRrjTh8zT7JyiLR8MsgeAsHZP+Y3q04P5HitLWyoJmnLMrWIShR/Eg==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr15891706wmf.21.1627898560854;
        Mon, 02 Aug 2021 03:02:40 -0700 (PDT)
Received: from pc-32.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id q14sm10688497wrs.8.2021.08.02.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 03:02:40 -0700 (PDT)
Date:   Mon, 2 Aug 2021 12:02:38 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to find out name or id of newly created interface
Message-ID: <20210802100238.GA3756@pc-32.home>
References: <20210731203054.72mw3rbgcjuqbf4j@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210731203054.72mw3rbgcjuqbf4j@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 10:30:54PM +0200, Pali Rohár wrote:
> 
> And now I would like to know, how to race-free find out interface name
> (or id) of this newly created interface?
> 
> Response to RTM_NEWLINK/NLM_F_CREATE packet from kernel contains only
> buffer with struct nlmsgerr where is just error number (zero for
> success) without any additional information.

You'd normally pass the NLM_F_ECHO flag on the netlink request, so the
kernel would echo back a netlink message with all information about the
device it created.

Unfortunately, many netlink handlers don't implement this feature. And
it seems that RTM_NEWLINK is part of them (rtmsg_ifinfo_send() doesn't
provide the 'nlh' argument when it calls rtnl_notify()).

So the proper solution is to implement NLM_F_ECHO support for
RTM_NEWLINK messages (RTM_NEWROUTE is an example of netlink handler
that supports NLM_F_ECHO, see rtmsg_fib()).

