Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499813B1EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:37:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:35:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1760069wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBmFBhpklfC3Qncyln1LP4dlHcSk41nDzHzs7pe65sY=;
        b=W9quFE//u3eazB729cqFLYm6zKTJAVoUcl6t0ugv9K39rY80iuIIVHFtP0pRlpkmvB
         IU2Lk9I1GbysXT7EGeaVbbehmXEOKQYgIuVFKAJJUEpyTR9r8wD+ob1kZeSJChqTEMyi
         WCggsUiCWJGsDyiPg4IXxrwhs9Mp3jXtcifO7PaZ93/cxv7ofMUy/uK+2g/Y9lim0pyL
         FcWPngkapJPqRNofUmeQDmgCRPmCTGWxqPiHtlEv6ROhdy52LRQv0JZqdTwOiFIDolY5
         GOMzmbjFPYkF/QZkZDiSfk44IK5Mf4lyEs5HyrAKOPX999mcbTDoLY92UwMawpvxFnKL
         TGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBmFBhpklfC3Qncyln1LP4dlHcSk41nDzHzs7pe65sY=;
        b=CScfv2uX8tPHTGqOfDieJ45uN9nybCMerA/BAOUiFn/KGMI6+AmuGH1TJOCP0GLKIw
         SPiijIdjpZcTATV6njxD2624lHZglMEPrqe/HobdFkMk0VmVKik7z334BOYG+U13pcpb
         FPWQTgSTYh1HSIvClH0Lf9/GQtIjIYjrVRxIp6Vnc9HPOU77pbWQv2j7zbk6MUTQ9GdW
         c0+RZz50TkpEJ1BsQ8Ph51mmXxV/Yjv3r0TVmlUf3OOXC20OXyFwiO4oneVfUF63ut/5
         y1czWvoTMz84LOH0LPGv7upqKBk0WDvReCos7RJvbxGoDUay7kkJyM/FLKoN2/WYMxrS
         tXeg==
X-Gm-Message-State: AOAM533VUa+mCknrXc3FsjqOLHrWqbVJrJI1GbX579WkalD/piLLLJUP
        j/dz68d9Sq8chxsNaphcSxPbds5Sa7q4UOXAwEP96g==
X-Google-Smtp-Source: ABdhPJxHKpMJq0hJPrEyYqbrMF7NXywPPMjLP8v9eppdHm8suZOeZfDlunTaSEmQdkwbIRqVtd1wRv5p4kki0ltSjxc=
X-Received: by 2002:a1c:f206:: with SMTP id s6mr679898wmc.102.1624466101169;
 Wed, 23 Jun 2021 09:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210622233529.65158-1-kuniyu@amazon.co.jp>
In-Reply-To: <20210622233529.65158-1-kuniyu@amazon.co.jp>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 23 Jun 2021 09:34:24 -0700
Message-ID: <CAK6E8=e_nP2_2OidZ0QZutieqORROTz-+X-NCGEr+uxM1W_btw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Add stats for socket migration.
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 4:36 PM Kuniyuki Iwashima <kuniyu@amazon.co.jp> wrote:
>
> This commit adds two stats for the socket migration feature to evaluate the
> effectiveness: LINUX_MIB_TCPMIGRATEREQ(SUCCESS|FAILURE).
>
> If the migration fails because of the own_req race in receiving ACK and
> sending SYN+ACK paths, we do not increment the failure stat. Then another
> CPU is responsible for the req.
>
> Link: https://lore.kernel.org/bpf/CAK6E8=cgFKuGecTzSCSQ8z3YJ_163C0uwO9yRvfDSE7vOe9mJA@mail.gmail.com/
> Suggested-by: Yuchung Cheng <ycheng@google.com>
Looks good. thanks

Acked-by: Yuchung Cheng <ycheng@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> ---
>  include/uapi/linux/snmp.h       |  2 ++
>  net/core/sock_reuseport.c       | 15 +++++++++++----
>  net/ipv4/inet_connection_sock.c | 15 +++++++++++++--
>  net/ipv4/proc.c                 |  2 ++
>  net/ipv4/tcp_minisocks.c        |  3 +++
>  5 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 26fc60ce9298..904909d020e2 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -290,6 +290,8 @@ enum
>         LINUX_MIB_TCPDUPLICATEDATAREHASH,       /* TCPDuplicateDataRehash */
>         LINUX_MIB_TCPDSACKRECVSEGS,             /* TCPDSACKRecvSegs */
>         LINUX_MIB_TCPDSACKIGNOREDDUBIOUS,       /* TCPDSACKIgnoredDubious */
> +       LINUX_MIB_TCPMIGRATEREQSUCCESS,         /* TCPMigrateReqSuccess */
> +       LINUX_MIB_TCPMIGRATEREQFAILURE,         /* TCPMigrateReqFailure */
>         __LINUX_MIB_MAX
>  };
>
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index de5ee3ae86d5..3f00a28fe762 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -6,6 +6,7 @@
>   * selecting the socket index from the array of available sockets.
>   */
>
> +#include <net/ip.h>
>  #include <net/sock_reuseport.h>
>  #include <linux/bpf.h>
>  #include <linux/idr.h>
> @@ -536,7 +537,7 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>
>         socks = READ_ONCE(reuse->num_socks);
>         if (unlikely(!socks))
> -               goto out;
> +               goto failure;
>
>         /* paired with smp_wmb() in __reuseport_add_sock() */
>         smp_rmb();
> @@ -546,13 +547,13 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>         if (!prog || prog->expected_attach_type != BPF_SK_REUSEPORT_SELECT_OR_MIGRATE) {
>                 if (sock_net(sk)->ipv4.sysctl_tcp_migrate_req)
>                         goto select_by_hash;
> -               goto out;
> +               goto failure;
>         }
>
>         if (!skb) {
>                 skb = alloc_skb(0, GFP_ATOMIC);
>                 if (!skb)
> -                       goto out;
> +                       goto failure;
>                 allocated = true;
>         }
>
> @@ -565,12 +566,18 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>         if (!nsk)
>                 nsk = reuseport_select_sock_by_hash(reuse, hash, socks);
>
> -       if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_refcnt)))
> +       if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_refcnt))) {
>                 nsk = NULL;
> +               goto failure;
> +       }
>
>  out:
>         rcu_read_unlock();
>         return nsk;
> +
> +failure:
> +       __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
> +       goto out;
>  }
>  EXPORT_SYMBOL(reuseport_migrate_sock);
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 0eea878edc30..754013fa393b 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -703,6 +703,8 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>
>         nreq = kmem_cache_alloc(req->rsk_ops->slab, GFP_ATOMIC | __GFP_NOWARN);
>         if (!nreq) {
> +               __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
> +
>                 /* paired with refcount_inc_not_zero() in reuseport_migrate_sock() */
>                 sock_put(sk);
>                 return NULL;
> @@ -876,9 +878,10 @@ static void reqsk_timer_handler(struct timer_list *t)
>                 if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
>                         /* delete timer */
>                         inet_csk_reqsk_queue_drop(sk_listener, nreq);
> -                       goto drop;
> +                       goto no_ownership;
>                 }
>
> +               __NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQSUCCESS);
>                 reqsk_migrate_reset(oreq);
>                 reqsk_queue_removed(&inet_csk(oreq->rsk_listener)->icsk_accept_queue, oreq);
>                 reqsk_put(oreq);
> @@ -887,17 +890,19 @@ static void reqsk_timer_handler(struct timer_list *t)
>                 return;
>         }
>
> -drop:
>         /* Even if we can clone the req, we may need not retransmit any more
>          * SYN+ACKs (nreq->num_timeout > max_syn_ack_retries, etc), or another
>          * CPU may win the "own_req" race so that inet_ehash_insert() fails.
>          */
>         if (nreq) {
> +               __NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
> +no_ownership:
>                 reqsk_migrate_reset(nreq);
>                 reqsk_queue_removed(queue, nreq);
>                 __reqsk_free(nreq);
>         }
>
> +drop:
>         inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
>  }
>
> @@ -1135,11 +1140,13 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
>
>                         refcount_set(&nreq->rsk_refcnt, 1);
>                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> +                               __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
>                                 reqsk_migrate_reset(req);
>                                 reqsk_put(req);
>                                 return child;
>                         }
>
> +                       __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
>                         reqsk_migrate_reset(nreq);
>                         __reqsk_free(nreq);
>                 } else if (inet_csk_reqsk_queue_add(sk, req, child)) {
> @@ -1188,8 +1195,12 @@ void inet_csk_listen_stop(struct sock *sk)
>                                 refcount_set(&nreq->rsk_refcnt, 1);
>
>                                 if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> +                                       __NET_INC_STATS(sock_net(nsk),
> +                                                       LINUX_MIB_TCPMIGRATEREQSUCCESS);
>                                         reqsk_migrate_reset(req);
>                                 } else {
> +                                       __NET_INC_STATS(sock_net(nsk),
> +                                                       LINUX_MIB_TCPMIGRATEREQFAILURE);
>                                         reqsk_migrate_reset(nreq);
>                                         __reqsk_free(nreq);
>                                 }
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index 6d46297a99f8..b0d3a09dc84e 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -295,6 +295,8 @@ static const struct snmp_mib snmp4_net_list[] = {
>         SNMP_MIB_ITEM("TcpDuplicateDataRehash", LINUX_MIB_TCPDUPLICATEDATAREHASH),
>         SNMP_MIB_ITEM("TCPDSACKRecvSegs", LINUX_MIB_TCPDSACKRECVSEGS),
>         SNMP_MIB_ITEM("TCPDSACKIgnoredDubious", LINUX_MIB_TCPDSACKIGNOREDDUBIOUS),
> +       SNMP_MIB_ITEM("TCPMigrateReqSuccess", LINUX_MIB_TCPMIGRATEREQSUCCESS),
> +       SNMP_MIB_ITEM("TCPMigrateReqFailure", LINUX_MIB_TCPMIGRATEREQFAILURE),
>         SNMP_MIB_SENTINEL
>  };
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index f258a4c0da71..0a4f3f16140a 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -786,6 +786,9 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>         return inet_csk_complete_hashdance(sk, child, req, own_req);
>
>  listen_overflow:
> +       if (sk != req->rsk_listener)
> +               __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
> +
>         if (!sock_net(sk)->ipv4.sysctl_tcp_abort_on_overflow) {
>                 inet_rsk(req)->acked = 1;
>                 return NULL;
> --
> 2.30.2
>
