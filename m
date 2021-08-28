Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3801A3FA65F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhH1PHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhH1PHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:07:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8984C061756;
        Sat, 28 Aug 2021 08:06:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g18so7677802wrc.11;
        Sat, 28 Aug 2021 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=P+sg7S7rHtibXd9SvMMU8OB3sAkFT9CGekE5f8GWaSk=;
        b=VLL/oSRtQyhtWyKcRpL6P0TbfvRG1byUhQFdCgiucIOxbAqHEkBp81PL3hKb0ME2Jm
         frBHAUIEBJN/CNfh/42Jvii3hS7KTJaobwLN15JjEp9HdLHf3LWnh4v5zPFp0V1hAFg8
         05fdC+yZXvyLIxpdu/VyJym17vUi/bV8aUf/sb9UQrnMfB+RrboXtMpYYwq1+HxbsJM3
         EpCP4ePGqsEDelEk+ydcpAivi1P9IA7BYwtWZNd3cZI6ECOUQ4+/vAgGuNEnu5Taav5u
         r0UbjceV4XWMAz8FvPqdHC/kLnrVWfHHJ3NJXDV0BjoW6G/6j+g6IeuxCjMu+DQAAw2E
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=P+sg7S7rHtibXd9SvMMU8OB3sAkFT9CGekE5f8GWaSk=;
        b=VmukoRRIwpOLjMVQ8gojAbbE7sFMJaNhisAYY1eqW0yDUSEZ4YXioAkIT6dtXicQb1
         tSBoczJXEgUtCd52o0wfQz/oTML6wSA+YBGh+etDteXdWG6UPbNFLdAX6CEOLO7dXNwV
         Ejv0x0Gbocjo6GRYqbflrmKFWW7BpYCTOhhYzobA+npzlbm2QPveHU5tE/ue4bHP4jv1
         CSIJpVPJaoBoXgXKawyFCOdg0Xq6crQKdr/ftS6tbWDjCqNHLPCquOwyMr9qBWaJ7EL1
         owJHSQBV6FUPX6qQEg/EYNr6FyfyLaaRzvrRvCV7BbcHXdZY4qnPUOR1oBCKZk8xMtmM
         3iQQ==
X-Gm-Message-State: AOAM532HkJQzgBpsvcRaZep5GIpr/KrFrbDYY//5IrmXE9gUNZJVmkPZ
        g3DKCIADXl7vwSievJnGIJxDSd6Z04w=
X-Google-Smtp-Source: ABdhPJynHoMKI44Vh5Z6kUneExJjpl8WCT5BX9QnjFuPExvYnT3liESzgpAFEZHnMAkRSlsFVlJ4Bg==
X-Received: by 2002:adf:b745:: with SMTP id n5mr16817319wre.338.1630163186411;
        Sat, 28 Aug 2021 08:06:26 -0700 (PDT)
Received: from [89.139.98.169] (89-139-98-169.bb.netvision.net.il. [89.139.98.169])
        by smtp.gmail.com with ESMTPSA id o8sm12752010wmq.21.2021.08.28.08.06.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 28 Aug 2021 08:06:25 -0700 (PDT)
Message-ID: <612A50C4.2080209@gmail.com>
Date:   Sat, 28 Aug 2021 18:05:40 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 0/4] char: xillybus: Remove usage of the deprecated
 'pci-dma-compat.h' API
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/21 20:17, Christophe JAILLET wrote:
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>    
Xillybus' driver is an example for why this is a good idea. But has this 
been decided upon? Are we sure that there isn't a single platform where 
the DMA mapping for PCI is different from non-PCI, and that such 
platform will never be?

If so, is there any reference to that decision?

I think the best way is to put a comment at the top of pci-dma-compat.h 
saying that the functions in that header file are deprecated and will go 
away soon. That would, more than anything else, convince people like me 
to get rid of those PCI-DMA function calls.

The bonus is that the discussion on the patch inserting that comment, 
along with the decision to apply or reject it, will become the 
authoritative word on this matter.

Thanks,
    Eli
