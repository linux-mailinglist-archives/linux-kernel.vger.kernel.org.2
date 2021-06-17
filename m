Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18C33AB724
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhFQPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhFQPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:19:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:17:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d9so3557353ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LIhMT1j3iJAaXNuZq7hCeQqZfqVMaOKz+Q/ejpSNsmM=;
        b=u0q5DeNvodHE8xRpUKhXNXBu+sU9kNfLU/cggfhap651/3HEdh64j4DtxLmv399HWs
         GLbwSArvZ8kWb3Ygw7zmUqaCwbeaF2uvJBejEL6wGXUmbX55P0S9vSMgK4A7kPW8WYVo
         4m/8QXXlAq6x4v1ru1WhfphsafwXUnSGv6brvYcg68mC/DWcksFwgUf5AdADtzjlywTU
         8QTie9FFUqCPFr8saxiet2Yr0z24PWiNKoEi9pEwcS5aSWaA24H4BXxfc1FZ1LMvnUVa
         FtCAow0S9EnjoTgLzL9K7Kzjnnk0PcTjLZa/F/jkool1KEiW1zNUa0Lq65iVRX5FprzM
         wM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LIhMT1j3iJAaXNuZq7hCeQqZfqVMaOKz+Q/ejpSNsmM=;
        b=Nkum5ghaktF8XR3/QqtEarCz9NYJFvdvb1eHtTQyNjLImvuTCo13PGL3KLV9Dyj/5k
         tvC/oYyA8uSWVvjSKxX2DODQwMfLEcRFlchcx0C4JGJniS3vdnXWcjBfvIY9rrWzLoJU
         ltC9K+pBPXsO5q0wRJCeH/YtZgVrSjUNqloM3eotFVVve8mwIRs6UJM3O2ig8V94uluV
         E5phlCDltViwf4wOHp4T5vkaraSAuMaeyG5RXjXOawnXOuJSFVnEqVBl1Gvj1HtLSOKl
         5h4S9rlb7yB39MWU8IBocZJr5M+ELGRERRAD9zrsQY3uHTfqOyIyR3kNC0AMBDRCgobh
         688w==
X-Gm-Message-State: AOAM533acsp2Nx52OMNlmHIJHgBi44qpKzYt9aXNUSlwhsyFs0q3YLAX
        A2k4Fnu9TDnoT3Dax/z25cM=
X-Google-Smtp-Source: ABdhPJzDzfwESP9Oxxp9U0vkxfzO3rKlzoHqYLE0FT4LsKmGJvFagAnunefg4nc8bNp/rVNARshp3Q==
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr5207242jad.131.1623943065959;
        Thu, 17 Jun 2021 08:17:45 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d18sm888035ils.5.2021.06.17.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:17:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id DD5B427C0054;
        Thu, 17 Jun 2021 11:17:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 17 Jun 2021 11:17:44 -0400
X-ME-Sender: <xms:mGfLYENoI1u02rK0lSe6K7-1r1dumMjWWTXivGUZR8wxRYovEFIzLQ>
    <xme:mGfLYK-yeR0nRhPfGVNaP3oTC7xdC6v8DytBVJydLYkWVa-f-7XBTS2jZbNalQjjH
    1PYqWCBnXXdfTZBQQ>
X-ME-Received: <xmr:mGfLYLSmDlZ8QiIBqlUJbx9TZjtSe54MosBKBVxUiu5GnzCf_sAedM2NMbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mGfLYMse1th2PetMonSSHS6ER-rfFyJ5lwM8pSc77oU5TU6EbA1f-A>
    <xmx:mGfLYMdCPVwupe8thfe8Bq2Dj6e97t02QU1T2m-wvgI7dGaDtVyr-A>
    <xmx:mGfLYA3VbvJUT7XAIHd1EMRcnkMpcPrw6LpwIxvgsTKQCiWxNmbsNA>
    <xmx:mGfLYERkl3SdierB5kAudywbICGUsUF4hnCf7eIHPa3yWuK5CMT8vg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jun 2021 11:17:44 -0400 (EDT)
Date:   Thu, 17 Jun 2021 23:17:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH] locking/lockdep: correct the description error for
 check_redundant()
Message-ID: <YMtnf4lOEiF++32w@boqun-archlinux>
References: <20210617150523.454965-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617150523.454965-1-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:05:23PM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> If there is no matched result, check_redundant() will return BFS_RNOMATCH.
> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Good catch!

Nit: you may want to capitalize the first letter after subsystem tag in
the patch title, like:

	"locking/lockdep: Correct ..."

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  kernel/locking/lockdep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cfe0f4374594..1f126ca7fbd7 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2726,7 +2726,7 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
>   * <target> or not. If it can, <src> -> <target> dependency is already
>   * in the graph.
>   *
> - * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
> + * Return BFS_RMATCH if it does, or BFS_RNOMATCH if it does not, return BFS_E* if
>   * any error appears in the bfs search.
>   */
>  static noinline enum bfs_result
> -- 
> 2.30.2
> 
