Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634544197A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhKAKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhKAKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:11:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96A8C08BED4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:47:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so11345046wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Yd+6d9rV/jwVQTnJUI4OXG6oZzc52v/02f336NZqpBQ=;
        b=ESR8ImqDefVwdNZn36vjzxKy9cfDJwpjgvG7tncJRYpKBqxF98ptBevmJntsYy36mf
         83ES21LRyQIK39LEfbldGPUh4Ex0Qh80ZLDZOe+AH9qqjRzHZmqr9q5FQVnL3nqgHGPa
         UmynCX04VLmp0yDaev53yxrO6DjVykuNLlHSpuxiKzWVxjctCg99Uofy8xntaMPLoMy5
         61Cxt9w6QiNuWzyLMsGS47i/jmYBsAPgdxSDPzl4wIGGpE4qNvKmHbtVQhncJdz128R7
         KW93uvHy5XuedUQKgcEk+VqzivNh6QiNgtmn7e1eBTxSdQdLOrWlueOM4ugfnG2WCkjS
         H1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yd+6d9rV/jwVQTnJUI4OXG6oZzc52v/02f336NZqpBQ=;
        b=45rmkK05ZgLs8ig1ApSS4bNZx1qjFZCYBrDMWM+3weQk/+DXjwcQRSFcPdr/RrEUXJ
         TcRn6vJxbKx5KSJ3fA0NX6DDIr+AXHT9icw+wum7ACuEz+gBSS7MPgN+s8MYyaw0MyBo
         436wuK2Hk+7EGCbSJnqbe0eUG+kEYAPpIfFondx72F8eL4JpKR2odoCESe5paD7PCbTW
         qaTaaH0//sk+oEbfdmYPcONRWK/Jqam8aIcP83MT6XH3pACLNh2RE0XBg3TxNSL6iFxw
         e27feegEiB5FsmCQuYTCmZZ/zxh4Na4wTTs4OzmR00rp0BwM6FXyrbAMRToXLnfl62st
         rrig==
X-Gm-Message-State: AOAM5310Prs9MWuk3j5ZnqBgown4n7PUZKaoCXLz72EokYWZ1EQlsXFI
        gzhAOeqH2lvCsLuVvZTtFP0=
X-Google-Smtp-Source: ABdhPJxfesZ16q2ywi0soXOKRKcF0O6lzpxtOdvfW1gHPGwVTNKed3cH5uVxIzx4pDEaVeZ+Vh5+Bg==
X-Received: by 2002:a05:600c:4303:: with SMTP id p3mr27583945wme.128.1635760033466;
        Mon, 01 Nov 2021 02:47:13 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id q1sm11696229wmj.20.2021.11.01.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 02:47:13 -0700 (PDT)
Message-ID: <edf5d0899f13414b2e5c1a6f1b6da08291e26e95.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 2/7] staging: vt6655: Use
 incrementation in `idx`
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Praveen Kumar <kpraveen.lkml@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 01 Nov 2021 09:47:07 +0000
In-Reply-To: <edfd74c7-9b6d-f8f5-65c4-c1bae3015247@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
         <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635415820.git.karolinadrobnik@gmail.com>
         <3dfc45e5-12bc-72da-a260-5551a483fe6e@gmail.com>
         <edfd74c7-9b6d-f8f5-65c4-c1bae3015247@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Praveen,

On Fri, 2021-10-29 at 21:11 +0530, Praveen Kumar wrote:
> However, as mentioned in previous patch, we can also make *i* as
> unsigned short and that should IMO remove the requirement of cast.

I agree, it should remove the cast but I think I'll leave `idx` as it
is.

> But again, this works as well. I'm fine with either. Thanks and sorry
> for the confusion.

No worries, thanks for looking at my changes. It's good to double check
everything :)


Thanks,
Karolina

