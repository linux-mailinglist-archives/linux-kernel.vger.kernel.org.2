Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A83AAE01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFQHxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:53:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59115 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhFQHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:53:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CEFA65C0148;
        Thu, 17 Jun 2021 03:51:42 -0400 (EDT)
Received: from imap8 ([10.202.2.58])
  by compute3.internal (MEProxy); Thu, 17 Jun 2021 03:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=J34v4eOphiFCnJRg9JzBcmNrvB6Q
        3Mbiylwq8e7rvEI=; b=LGsdpL+h2D29ZXAsXztwJ7sXGkPJ2JIoIc7f2uih+07w
        D0iIAyw/ki2xWFCa6gi9VUvLOVLAISyTAmJ7adYJN+KhOgaqX7A5+9Odwx5CgTjV
        QtidJ7or0iM5nvtHzg8lQhrQEtSg5+diA0ZsJoibG7eMlZSz2gyAQOzgqrhX2UQs
        xHn5oINhdDWxCxNo7yEQXUCHGzpkU/6QHpzvhm8nZLQn2SyIc7tuyabFnOpmsiBW
        nWPdTgQy6CFTy/6FEQnzGNlzudsE0gw5Aod4j9YuTLIEhVoYPo7Kvn0nI9rkejWb
        e6w5vK6dtjAQLq+V3mBqNB+gRcZqp9nI5Rf0ZuCkzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=J34v4e
        OphiFCnJRg9JzBcmNrvB6Q3Mbiylwq8e7rvEI=; b=jqMVp5gU7EamanV78S7Vnq
        UFqXZTEbXe+ncufwd0wjfa7PaaAGK3ItG8ik88bw6pFerWFPJr245Id6WwmUGQFR
        NiaoRLQPIZK7SmqCT8HhsRktuIvza6IHBkCqswVwCO2f8WsjQ+wP40HtdLSpEfrF
        BRwgPcb8ryoEfoyi8uGBDJuJCJ6ttt3ng7hloJegOyxDIFUqGaYftq8wvOHbMQfo
        8CrMfyvTeKkLe225+eOHQXKyQtBqYenY0FM1CGOd+eDFsEXsr45tUjkZy49IvPBL
        1rtyP0CojXu/ko2QJd+cu2f/aObqm45ZtSXjUsGDFfyhPLIxMy8hfV5VFTwT76Jw
        ==
X-ME-Sender: <xms:Dv_KYMQOAGGKconR3bqUDQQn9WrnOZ2XQfPZO4QoyWQcFnOGdI-NEA>
    <xme:Dv_KYJx98DaBdoLj0paDao64kZRAJRzduntXA_FxYzJX2nkdYqQjHaet9A4wgrmNM
    LBJNzbDxdO48QdOlKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpeetlhhi
    shhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepffehffffleduieeitdehudelteevueevgeduuddtjeekvddvvdeugfel
    udekhfehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:Dv_KYJ37b4CuIGa6UGKT95_OXxBAUaBoN4Z29xEWnjs1atCIrjdlLw>
    <xmx:Dv_KYACcXKvMeIRH2vxCw31C321fbT8IXHAq_ODoFWsdUAPwWrMXuA>
    <xmx:Dv_KYFgw2jaCEUjXyqk__meQP7qijn1GTZ-ay_NrcJqL8bn-6a5NpQ>
    <xmx:Dv_KYIvwqfc1sfavfGDM_aBPUJpeV3dYRbae72YGF1rtKTpjkZ_qHQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6D0813A0430; Thu, 17 Jun 2021 03:51:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <587cea0c-ebf5-470f-8c40-d49532b14a5c@www.fastmail.com>
In-Reply-To: <20210617024838.1023794-1-weiyongjun1@huawei.com>
References: <20210617024838.1023794-1-weiyongjun1@huawei.com>
Date:   Thu, 17 Jun 2021 17:51:22 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Wei Yongjun" <weiyongjun1@huawei.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, "Hulk Robot" <hulkci@huawei.com>
Subject: =?UTF-8?Q?Re:_[PATCH_-next]_regulator:_sy7636a:_Add_terminate_entry_for_?=
 =?UTF-8?Q?platform=5Fdevice=5Fid_tables?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021, at 12:48 PM, Wei Yongjun wrote:
> Make sure platform_device_id tables are NULL terminated.
> 
> Fixes: 8c485bedfb78 ("regulator: sy7636a: Initial commit")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> drivers/regulator/sy7636a-regulator.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index c384c2b6ac46..672b7055131d 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -110,6 +110,7 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
>  
> static const struct platform_device_id sy7636a_regulator_id_table[] = {
> { "sy7636a-regulator", },
> + {},
> };
> MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
>  
> 
> 
