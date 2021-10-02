Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4678841F8F1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 03:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJBBG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 21:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhJBBG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 21:06:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBD6861A81;
        Sat,  2 Oct 2021 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633136681;
        bh=+gLy8MuYSKBFJLy5QzWpgsKEfDMWBx7rJCpaE1zfZQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DuqZBdpKxO71SIiHLz+j4ZX3ZUAF7Whr8KPhFKuA/1Uz8kEgHNpqw6blZpypesFGN
         TN0DsCOZ37yYkBpgNiEZgcTbAmHfsXUztggB3HCoFz8Dpv5qOfPb4HmFw45Q9eClon
         uZUPGA0AV6HLCxRZb6B/edNKXAG7LLaLl5h5ZcIJzAfBYnQS85q3h18zJ3cwohFq5M
         gH45kAZR18R/H55mI/T2UuUXB9/cOBu6wbQbGBXamZjncbSVKve7+M2QZCObTDMMoB
         rMbTFX2vBpFE2+2MZD+lxCfd4MWq3ijUzNCf/WYEVPNeRHO8f7KkFOFU0eutyTNwsT
         hcGGIqa8jKzWA==
Date:   Fri, 1 Oct 2021 18:04:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Cong Wang <cong.wang@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Rao Shoaib <Rao.Shoaib@oracle.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Subject: Re: [PATCH] af_unix: add missing annotation at
 bpf_iter_unix_seq_stop()
Message-ID: <20211001180439.55bdc79f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211001234938.14806-1-jbi.octave@gmail.com>
References: <20211001234938.14806-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Oct 2021 00:49:37 +0100 Jules Irenge wrote:
> Sparse reports a warning at bpf_iter_unix_seq_stop()
> The root cause is a missing annotation at bpf_iter_unix_seq_stop()
> 
> Add the missing __releases(unix_table_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index efac5989edb5..9838d4d855e0 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3291,6 +3291,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>  }
>  
>  static void bpf_iter_unix_seq_stop(struct seq_file *seq, void *v)
> +	__releases(unix_table_lock)
>  {
>  	struct bpf_iter_meta meta;
>  	struct bpf_prog *prog;

You need to CC bpf@vger... and netdev@vger...

You can drop the CC for linux-kernel@, approximately nobody reads that.
