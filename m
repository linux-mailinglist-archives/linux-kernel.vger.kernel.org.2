Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD4443770
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKBUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhKBUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:45:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 13:42:49 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g8so211819iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=K/fqbzKS7d7M3R+dtjsJkzxyoCQ0qXkQ3ZMxTQROrjY=;
        b=0jOnt+d6rkjr0xYYasEo/Cma/n2fhTr9QJnbA/Dl6G6MGmPUSK5+5R2eLkwDRV1k7U
         sBzxiL42a6mqjwsXausPbWMjLIzjKxpjYwyJ5RwlsOcoPaT6X6p/UfKxYOtHtqyC6GU7
         ugH3ygUqUOXgNZzKTne4c4ffQ42OzTL7p3xZ0IHMHerTc5oCKis+UAZPqMtiaMo6vnPK
         0izcH3MXVr187f2PCLw4kyNhDOBm1INviqGtyNz1Afr1kzgkmepYbcT1LdDFCeR8OOnW
         757T3j+hhV6QIPMDLWCjeCSOp/jTZ7Sc6M0jUC/lqnAic7kKpQEdsrWbcJTcFiRXj/3K
         BaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=K/fqbzKS7d7M3R+dtjsJkzxyoCQ0qXkQ3ZMxTQROrjY=;
        b=7YGf/GG8EJo6wprKhwV+8jt5DMKDno/cJMUUyp+gLtNjnaWkirkTPVIRm1IS3h3eG3
         kkH/Ur2aO/e3cY9VTq/sjB+WJbdDfHZ/NNe/3umOZrK0mZv2jG9YqH57NGa3vLQeMdwG
         BcLzfI6aPiMqrbp2uFK0A3gMoPNXokpsIfmYnFV8UA5Pno2MQinJktaxlK3fxWHPnnuF
         cXYe5W5P9bATK1cu6Z9InSgGEZ6wA85DxqSaDe7/ClmdEOkvOYv4sg3N+4y/h3y6VpBF
         qdRX9i3GvGu85KuXXE7EZV93D6AcYUG4YMYy7U2iKRvXB2lKYyXRV15fw7g6Lan18kmN
         Wnuw==
X-Gm-Message-State: AOAM530oFyl+UOrqDVpGeLtqlCpX6YOe59QKjv30O7Oj/E5WKsyhJ+if
        lC2P1H+2cECPviBoX1C1G+N+MQ==
X-Google-Smtp-Source: ABdhPJz3m9eBOhDC5NdhELv5Gcmquw7Vd2ye9VvFsUfeC26PRRr6aNPvdUP7IEkS1SlWnuJobt6JKw==
X-Received: by 2002:a5d:8242:: with SMTP id n2mr27354163ioo.170.1635885768482;
        Tue, 02 Nov 2021 13:42:48 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n4sm84359ili.10.2021.11.02.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:42:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Yu Kuai <yukuai3@huawei.com>
Cc:     yi.zhang@huawei.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211101092538.1155842-1-yukuai3@huawei.com>
References: <20211101092538.1155842-1-yukuai3@huawei.com>
Subject: Re: [PATCH] nbd: error out if socket index doesn't match in nbd_handle_reply()
Message-Id: <163588576788.463006.5186111103177394887.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 14:42:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 17:25:38 +0800, Yu Kuai wrote:
> commit fcf3d633d8e1 ("nbd: check sock index in nbd_read_stat()") just
> add error message when socket index doesn't match. Since the request
> and reply must be transmitted over the same socket, it's ok to error
> out in such situation.
> 
> 

Applied, thanks!

[1/1] nbd: error out if socket index doesn't match in nbd_handle_reply()
      commit: 494dbee341e7a02529ce776ee9a5e0b7733ca280

Best regards,
-- 
Jens Axboe


