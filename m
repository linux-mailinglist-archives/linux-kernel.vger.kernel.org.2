Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C895410FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhITHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhITHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:04:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78503C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:03:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so27047569wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DG0OP+1y594O5YGKD3ZZ0Nlbz4qLu5WAXynIGhFqivg=;
        b=ll9ykXSQP9wg5fLyqZxirj1lF9lzPZX5c8HfsrjpPxfJhE3O7OkB/6lM6be84Xr/c4
         8kXPjW+d8IHixBxhLZkkMYpD3CC5ogp1EzfKkkFf6uXajQ6CulVFitrPSCbw4dExPCSm
         tjWO0yGg75+4c/1X5Txk7niPs5bgfzYWe1YX9zH7CLv2ffa2VIuHJCQ7TxnAaT/1mF6m
         aTauWgsT+7P22eT/ax7AF53g27egLJPfleQtKTWMJ+Gm0MEkZSrfCIYqA/mY8oYHo9vP
         /vIMHEqTaPf90kHppUnxVKPi49Eu8bLa+talwJ3VOCwvTk2wIoELQXjw0s5tVbd66oSt
         TUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DG0OP+1y594O5YGKD3ZZ0Nlbz4qLu5WAXynIGhFqivg=;
        b=nBrjwfvUi235wIbV2swUa1wH85/+FXv86Hjmr2khPZgo9FvCKSk/BijGV2pKKQNnCe
         /+/nU+oJRpH7otsWbeC8+ZVVWAiM7uwDQ0kMuoMfwa7gL7dFGvCrfxf/vl1DB2rwX3ho
         zFSEARGMnNanz+QSjG8NodgJhJe31OrLhil1qAvcgKRzf1hz83SZ5kZLPaWq+PcXTpez
         rzR3BxtEQm9mwWF4RNihF1xH0WYncoVb2EJdZfQ6Sgs3DbmumxIPXJCXhLy751tdFnaa
         noaxKY3aUeiMd71JUjXi5BaYORxFe1ZLzCk4br9mTSRnfxL7JDK850lGKtYnHZEifDuJ
         GkGA==
X-Gm-Message-State: AOAM53330TUmmPZeiAslr0UiGoh4OJEgKCJwHkpFLQ1nV3zxWBB++cno
        WNDghkqmXJuzI1RUd/SD+AQ=
X-Google-Smtp-Source: ABdhPJyW07B4DX3amfp985birr+UI89oJdLyDF7kn4j8YwrkEXzm1AUwSEbdMDIj9TtLVPOZSx79/w==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr26941932wrq.37.1632121394169;
        Mon, 20 Sep 2021 00:03:14 -0700 (PDT)
Received: from agape.jhs ([5.171.73.38])
        by smtp.gmail.com with ESMTPSA id f8sm6982977wrx.15.2021.09.20.00.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:03:13 -0700 (PDT)
Date:   Mon, 20 Sep 2021 09:03:11 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] extcon: extcon-axp288: use P-Unit semaphore lock for
 register accesses
Message-ID: <20210920070310.GA1436@agape.jhs>
References: <20210916071255.2572-1-fabioaiuto83@gmail.com>
 <77beb286-09fb-3d9c-f212-91c1633dbd10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77beb286-09fb-3d9c-f212-91c1633dbd10@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chanwoo,

On Sun, Sep 19, 2021 at 06:33:47PM +0900, Chanwoo Choi wrote:
<snip>
> 
> Applied it. Thanks.

thanks a lot

> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

fabio
