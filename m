Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07362375119
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhEFIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEFIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:51:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3EC061574;
        Thu,  6 May 2021 01:50:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c3so6674601lfs.7;
        Thu, 06 May 2021 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQzYD8IMdKxKUQHT8Y9HzqUwvH2gLhXKjYg9fagd5/c=;
        b=uGtvohP514NsY1pQwvQlV2/nAq2R+d+/fvuUXsrW7wmw10qx+2P32KmM+k1Kz5V5bT
         nf8rlm56/VF7YPEQgcil36ARt7xSX2hDgo2CkMuH6AhoSM/cYpMfJ0E8RrP01k9gw2JB
         SzRqcZ9LDZJB88GUWTThaz+/PO3fyKHhPzFOhV6CtjT3uWWn+9WTxMnidJ3LICa8YMqn
         ySfiIewxkAmsMuPQ59kyt9H2lHv3q9+BDb2YXHmrh7xIzIDd40xtdHxZ8h2dX9u/YRXt
         1/8IeB8r9JAWWqDTagZCfIj3fi1/LZQNnCusMKLVkeM1FRF70xVv5oKa403Nyci5qTbJ
         MZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GQzYD8IMdKxKUQHT8Y9HzqUwvH2gLhXKjYg9fagd5/c=;
        b=a8+pKAzjKWmfk29PB6ewfsG/uWrsyWau6IutTA9o5YYrgcYHJUB2crI26M4znhIQH/
         0gER9wQ0Q4Ws5mOwYVJo6JfXmI5LcBagQKqWAmt93s+ZcrzmAnrVBCJlQBLS6XCYQH9O
         LxYQtFGnv0IKM94ARlhq3rDIjUTuhvb20gf0SfMQP6NJG2tdnEwlY88iUYDJbldWAJZn
         HluYMzt1NqOwrrSn2+HGe89XczL2h4AJa8pzQqOvixEJ/fyxsbnPDYJm9xhnvTqi5IVC
         vIzpnALu2qk8Cn6bqsSmT3QqyAC00HctO6GDGMzKv7TbmuP4JXnPQtuQVA/Csqk8VbyA
         ZNfQ==
X-Gm-Message-State: AOAM530aA6Vugo/zv9UOopxCbk2zKviVDcjOYgpRUOQBKDxi3TF4k2Jv
        EkNqV4nxSbsmrjeQoWkHGOs=
X-Google-Smtp-Source: ABdhPJx72N5YWuM1xVu+aCni/65ECaH9pXVrqgltse4psZObd0GtgeyfvhXQxrB1Mukmwop4ZfuwKA==
X-Received: by 2002:a05:6512:3d8f:: with SMTP id k15mr2234631lfv.227.1620291017411;
        Thu, 06 May 2021 01:50:17 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.80.19])
        by smtp.gmail.com with ESMTPSA id n16sm505586lfe.245.2021.05.06.01.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:50:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] usb: xhci-mtk: use bitfield instead of bool
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <a3d1a695-3138-f322-3b4f-5d00e9c85a50@gmail.com>
Date:   Thu, 6 May 2021 11:50:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06.05.2021 9:31, Chunfeng Yun wrote:

> Use bitfield instead of bool in struct
> 
> Refer to coding-style.rst 17) Using bool:
> "If a structure has many true/false values, consider consolidating
> them into a bitfield with 1 bit members, or using an appropriate
> fixed width type, such as u8."
> 
> Due to @has_ippc's default vaule is 0, no need set it again if fail

    Value. :-)

> to get ippc base address
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
