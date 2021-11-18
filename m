Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4E4556D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbhKRIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbhKRIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:18:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D10C061767
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:12:58 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637223176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9FqOtxstrySs/VJ0wyS7gYGUA4oag5icUozXg+aW14=;
        b=q4tbb3yE557byvmmBTf6y8Z6A2sQN1OJXsvMWb3HFY2QpGUZEYMiFT4HFQ7w1lpBirJjc5
        G0ydRcJnwZkmmgQ/eXCrUcCczqXcESBlSjcNgLbrUj7rrTkzPYV2oQHW9XKrgP7lIx6blu
        icVEvD5vwWsvR4/WYL/uKD6ejwcMPiM=
Date:   Thu, 18 Nov 2021 08:12:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <a4b7401c06d3baa5d3d0a43d7aa6c62c@linux.dev>
Subject: Re: [PATCH] refcount: introduce refcount_is_one() helper function
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20211118074200.GF174703@worktop.programming.kicks-ass.net>
References: <20211118074200.GF174703@worktop.programming.kicks-ass.net>
 <20211118035328.5730-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 18, 2021 3:42 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:=
=0A=0A> On Thu, Nov 18, 2021 at 11:53:28AM +0800, Yajun Deng wrote:=0A> =
=0A>> There are many cases where it is necessary to determine if refcount=
 is one,=0A>> introduce refcount_is_one() helper function for these cases=
.=0A> =0A> Give me one that is not racy?=0A=0AThe following determine ref=
count is one, 35 count.=0Alinux (next-20211117) $ grep "refcount_read.*=
=3D=3D 1"  ./  -RnI=0A./tools/lib/perf/mmap.c:              101:	    if (=
refcount_read(&map->refcnt) =3D=3D 1 && perf_mmap__empty(map))=0A./tools/=
perf/tests/cpumap.c:           72:      TEST_ASSERT_VAL("wrong refcnt", r=
efcount_read(&map->refcnt) =3D=3D 1);=0A./tools/perf/tests/thread-map.c: =
      42:		refcount_read(&map->refcnt) =3D=3D 1);=0A./tools/perf/tests/th=
read-map.c:       57:		refcount_read(&map->refcnt) =3D=3D 1);=0A./tools/p=
erf/tests/thread-map.c:       84:	    refcount_read(&threads->refcnt) =3D=
=3D 1);=0A./tools/perf/tests/maps.c:             28:		TEST_ASSERT_VAL("wr=
ong map refcnt", refcount_read(&map->refcnt) =3D=3D 1);=0A./include/linux=
/skbuff.h:            1078:	    if (likely(refcount_read(&skb->users) =3D=
=3D 1))=0A./include/net/sock.h:                 726:		WARN_ON(refcount_re=
ad(&sk->sk_refcnt) =3D=3D 1);=0A./include/net/sock.h:                 748=
:		WARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);=0A./net/core/neighbou=
r.c:               214:	    if (refcount_read(&n->refcnt) =3D=3D 1) {=0A.=
/net/core/neighbour.c:               264:		if (refcount_read(&n->refcnt) =
=3D=3D 1) {=0A./net/core/neighbour.c:               965:		if (refcount_re=
ad(&n->refcnt) =3D=3D 1 &&=0A./net/core/dev.c:                    3017:	 =
   if (likely(refcount_read(&skb->users) =3D=3D 1)) {=0A./net/core/skbuff=
.c:                  710:		if (refcount_read(&fclones->fclone_ref) =3D=3D=
 1)=0A./net/core/skbuff.c:                 1514:	    refcount_read(&fclon=
es->fclone_ref) =3D=3D 1) {=0A./net/core/skbuff.c:                 6278:	=
    if (refcount_read(&old->refcnt) =3D=3D 1)=0A./net/core/skbuff.c:     =
            6402:		refcount_read(&ext->refcnt) =3D=3D 1) {=0A./net/core/s=
kbuff.c:                 6417:	    if (refcount_read(&ext->refcnt) =3D=3D=
 1)=0A./net/netlink/af_netlink.c:           614:		WARN_ON(refcount_read(&=
sk->sk_refcnt) =3D=3D 1);=0A./net/tipc/socket.c:                 3032:		W=
ARN_ON(refcount_read(&sk->sk_refcnt) =3D=3D 1);=0A./net/netfilter/ipvs/ip=
_vs_conn.c:    480:	    (refcount_read(&cp->refcnt) =3D=3D 1) &&=0A./net/=
sctp/auth.c:998:	    refcount_read(&key->refcnt) =3D=3D 1) {=0A./drivers/=
tty/serial/sb1250-duart.c:  698:	    if (refcount_read(&duart->map_guard)=
 =3D=3D 1) {=0A./drivers/infiniband/core/cm.c:      1048:	    WARN_ON(ref=
count_read(&cm_id_priv->refcount) =3D=3D 1);=0A./drivers/infiniband/hw/ir=
dma/utils.c:513:		refcount_read(&cqp_request->refcnt) =3D=3D 1, 1000);=0A=
./drivers/crypto/caam/qi.c:           306:		if (refcount_read(&drv_ctx->r=
efcnt) =3D=3D 1)=0A./drivers/net/ethernet/mellanox/mlx5/core/fs_core.c:16=
33:		if (refcount_read(&handle->rule[i]->node.refcount) =3D=3D 1) {=0A./d=
rivers/net/vxlan.c:               1537:	    if (family =3D=3D AF_INET && =
sock4 && refcount_read(&sock4->refcnt) =3D=3D 1)=0A./drivers/net/vxlan.c:=
               1541:	    if (family =3D=3D AF_INET6 && sock6 && refcount_=
read(&sock6->refcnt) =3D=3D 1)=0A./kernel/events/core.c:             1286=
1:		wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) =3D=3D 1=
);=0A./fs/nfs/nfs4proc.c:                 9127:		if (refcount_read(&clp->=
cl_count) =3D=3D 1)=0A./fs/lockd/mon.c:                     195:	    if (=
refcount_read(&nsm->sm_count) =3D=3D 1=0A./fs/btrfs/transaction.c:       =
     2061:	    ASSERT(refcount_read(&trans->use_count) =3D=3D 1);=0A./fs/=
btrfs/block-group.c:            3960:		ASSERT(refcount_read(&block_group-=
>refs) =3D=3D 1);=0A./fs/afs/write.c:                     921:	    if (re=
fcount_read(&wbk->usage) =3D=3D 1)=0A=0AThe following determine refcount =
isn't one, 19 count.=0Alinux (next-20211117) $ grep "refcount_read.*!=3D =
1"  ./  -RnI=0A./include/linux/skbuff.h:                                1=
762:	return refcount_read(&skb->users) !=3D 1;=0A./include/net/sock.h:   =
                                 1297:	if (refcount_read(&sk->sk_refcnt) =
!=3D 1)=0A./crypto/algapi.c:                                        461:	=
BUG_ON(refcount_read(&alg->cra_refcnt) !=3D 1);=0A./crypto/algapi.c:     =
                                   560:	BUG_ON(refcount_read(&inst->alg.c=
ra_refcnt) !=3D 1);=0A./net/sunrpc/auth.c:                               =
       690:	if (refcount_read(&cred->cr_count) !=3D 1 ||=0A./net/llc/llc_=
conn.c:                                     977:	if (refcount_read(&sk->s=
k_refcnt) !=3D 1) {=0A./net/ceph/osd_client.c:                           =
      5297:	WARN_ON(refcount_read(&osdc->homeless_osd.o_ref) !=3D 1);=0A.=
/net/ipv6/ip6_fib.c:                                    1037:	if (refcoun=
t_read(&rt->fib6_ref) !=3D 1) {=0A./net/core/neighbour.c:                =
                   349:	if (refcount_read(&n->refcnt) !=3D 1) {=0A./net/c=
ore/pktgen.c:                                     3430:	while (refcount_r=
ead(&(pkt_dev->skb->users)) !=3D 1) {=0A./drivers/crypto/marvell/octeontx=
/otx_cptvf_algs.c:      1584:	if (refcount_read(&otx_cpt_skciphers[i].bas=
e.cra_refcnt) !=3D 1)=0A./drivers/crypto/marvell/octeontx/otx_cptvf_algs.=
c:      1587:	if (refcount_read(&otx_cpt_aeads[i].base.cra_refcnt) !=3D 1=
)=0A./drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c:406:		refc=
ount_read(&lkey_id->refcnt) !=3D 1, lkey_id->id,=0A./drivers/net/ethernet=
/mellanox/mlxsw/spectrum_acl_atcam.c:435:			     refcount_read(&lkey_id->=
refcnt) !=3D 1,=0A./drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atca=
m.c:464:			     refcount_read(&lkey_id->refcnt) !=3D 1, lkey_id->id,=0A./=
drivers/block/nbd.c:                                    2541:		if (refcou=
nt_read(&nbd->refs) !=3D 1)=0A./fs/exec.c:                               =
               1182:	if (refcount_read(&oldsighand->count) !=3D 1) {=0A./=
fs/btrfs/tests/extent-map-tests.c:                        24:		if (refcou=
nt_read(&em->refs) !=3D 1) {=0A./arch/s390/mm/extmem.c:                  =
                 472:	if (refcount_read(&seg->ref_count) !=3D 1)=20{
