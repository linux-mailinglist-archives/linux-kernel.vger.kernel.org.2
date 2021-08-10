Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930A3E7C92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbhHJPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243518AbhHJPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PosN/BQlgO407DGmnaZ7DbLvbofuu3rHwhQkO8w4Da4=;
        b=cuwR9+lWHdTnwtn79tY4bPvb072LvOJ+bOQ3IScQ1KM5gsgNqTM/1Xysk4Nt4ZrPgy40BM
        6wHdT2ZplRq9hheOLOkMvKJSkbp72xnhTFRDgrjkYRA4hxdS15utn1F7gFuHyvNjooJ17q
        ftKn6omadXhAHOnWxvi8ztWUPOZI11w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-CRCM_xSNMo2Nl2Dig5niPA-1; Tue, 10 Aug 2021 11:39:45 -0400
X-MC-Unique: CRCM_xSNMo2Nl2Dig5niPA-1
Received: by mail-wm1-f72.google.com with SMTP id u15-20020a05600c210fb02902e6a5231792so360179wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PosN/BQlgO407DGmnaZ7DbLvbofuu3rHwhQkO8w4Da4=;
        b=QXUqodHoYbaXZ5ohrUFoW4prtljeuTgvhb+q66Cgfl2hB/q/pGuoHD032eWK74O9Wf
         ZUET9E/a5byZZ9FDkg1NgoJIbT65iwhGlvYCvlAdgXa107HShBJqt1SZpT2irPGTyqKG
         z8amuyEzv1c+xeZ/kLq0e9VR/9V1ZhR37IubJBk9wgls+7vZz6VtbEuqYd8bOVJDerQl
         DGGstcu/A5C423dRrZIayokzxx6Mv4fgowirJPnIjtpuQGCh6R29f/nHgcRpgN/S3mgs
         7bU1+EBSXEeU9posWNT78ld7QF1TJuU7y5PtqjuuvPCK1J/VHYuDTPUcb/hSsoQfHCqK
         4XWQ==
X-Gm-Message-State: AOAM531ApjNlhu6mwK5tij89IIu0ZJo6cD+xz7sLEU8tDgNjkwQw078P
        Yl95a7f54BnFMMPAJru3kyx24GKWEz6VWCZF3YDI5rMugK28ESC351VQVbR36SdNSGfP9jWJWe3
        wRCU94emLzEkfkdjVMRKWOQjF
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr3626178wmc.7.1628609984546;
        Tue, 10 Aug 2021 08:39:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw72W8jCGvxKisUudy1C9Uk3WRrkPv1bMEx4uTRO/fxaJ6DDCtTXdBXdyOy3DU2WnJ8uX49ww==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr3626164wmc.7.1628609984390;
        Tue, 10 Aug 2021 08:39:44 -0700 (PDT)
Received: from pc-32.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id p8sm3029396wme.22.2021.08.10.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:39:43 -0700 (PDT)
Date:   Tue, 10 Aug 2021 17:39:41 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: Add rtnl attribute IFLA_PPP_UNIT_ID for specifying
 ppp unit id
Message-ID: <20210810153941.GB14279@pc-32.home>
References: <20210807163749.18316-1-pali@kernel.org>
 <20210809122546.758e41de@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210809193109.mw6ritfdu27uhie7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809193109.mw6ritfdu27uhie7@pali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 09:31:09PM +0200, Pali Rohár wrote:
> Better to wait. I would like hear some comments / review on this patch
> if this is the correct approach as it adds a new API/ABI for userspace.

Personally I don't understand the use case for setting the ppp unit at
creation time. I didn't implement it on purpose when creating the
netlink interface, as I didn't have any use case.

On the other hand, adding the ppp unit in the netlink dump is probably
useful.

