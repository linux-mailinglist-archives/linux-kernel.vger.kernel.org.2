Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453C6351FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhDAT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhDAT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:29:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B21C0610E0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:21:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t20so1486415plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=HbgURG3oZJI8peiYJ47Xrk9y5ZJA0pTdMQGeypLtuzA=;
        b=BzYNuSVwkeosizznb4U6wvdKT9P19ptL93d7gZDGWR+1UROQFmfXTi8J0brxLrsesd
         nF6yGNKPi/1oDh4zi/AdHCqjahSFgTvyzogJ6J1TYDqCvwmZL8514GPHV0ECOzlGd8XO
         zvzwEJkRGfeZQGAWolHMyKnEDUhqUJ0/iSZuZ79c6x3F1+n9MdDkYyPkb+RHcJui+t4i
         eMl9AsbgBDcHByvxVFmtzrPPDODu/QGa37w5HrDUqCtbIOuwVSbiGKnHwYe07Z4n0JuR
         AeOtK0IYLACrEkPjKaQztkWoV0+37eaza0H1qk9X8ftOIhQBx3PqopP18jrxtqnZZ93G
         kRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=HbgURG3oZJI8peiYJ47Xrk9y5ZJA0pTdMQGeypLtuzA=;
        b=dRhwWtgvwzNxTcem1ZyZJrhW70CVljTfcbD2t7KFbmUILhWLW+DVzfLIS6K+HhFyee
         oWE/0USY4gWjhL2Yn5w79CfpJdR7Y3q7O2N3KuJYl3C6S4T+n4vtyCL5m4PxYC/H+RLC
         Ya47w1DCXPuglsdrA70I/iJtZEhm5l0ExxWYuXq9vMcXGA5V6HA3MF83l5A7zi/SC2uP
         Z6urqRVpxHtI7hWTr5RwHDcpgxs+qjKdcoSj/gOu1BbW3Oc/v39RbM9rGUbegoXs5W1m
         brAFRP9Vpsfc8hoBR511nGIo1Rj+C1iFs+pMTvUuS0V4scCc8gIhKwywLFnAZGOyaQuS
         iVzA==
X-Gm-Message-State: AOAM533Z1p2KWwqKGheulyIX16ddadXZB4pKXJk2rpmeOSOrAz0vd8BF
        E7Qeng/64mfS5ShKkMmFsQU=
X-Google-Smtp-Source: ABdhPJxORTF7J6CpoEywQ0luCEGj3f9ZOuJSKRtrgM7n8NywgNlvwPMOMv2X3hsTIXWa0GYmW+iUoA==
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id p6-20020a170902a406b02900e678c471c8mr9255966plq.17.1617304908637;
        Thu, 01 Apr 2021 12:21:48 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y4sm5919923pfn.67.2021.04.01.12.21.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 12:21:47 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <1F67895A-C2CA-481D-AB33-58E8201BCE71@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_893D95E3-DB07-4148-AC61-E60F3DABEC09";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on
 hint page fault
Date:   Thu, 1 Apr 2021 12:21:46 -0700
In-Reply-To: <20210401083809.GX15768@suse.de>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mel Gorman <mgorman@suse.de>
References: <20210329062651.2487905-1-ying.huang@intel.com>
 <20210330133310.GT15768@suse.de>
 <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <20210331131658.GV15768@suse.de>
 <C42F16F8-646B-448D-A098-E1A98637E28D@gmail.com>
 <20210401083809.GX15768@suse.de>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_893D95E3-DB07-4148-AC61-E60F3DABEC09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 1, 2021, at 1:38 AM, Mel Gorman <mgorman@suse.de> wrote:
>=20
> On Wed, Mar 31, 2021 at 09:36:04AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Mar 31, 2021, at 6:16 AM, Mel Gorman <mgorman@suse.de> wrote:
>>>=20
>>> On Wed, Mar 31, 2021 at 07:20:09PM +0800, Huang, Ying wrote:
>>>> Mel Gorman <mgorman@suse.de> writes:
>>>>=20
>>>>> On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
>>>>>> For NUMA balancing, in hint page fault handler, the faulting page =
will
>>>>>> be migrated to the accessing node if necessary.  During the =
migration,
>>>>>> TLB will be shot down on all CPUs that the process has run on
>>>>>> recently.  Because in the hint page fault handler, the PTE will =
be
>>>>>> made accessible before the migration is tried.  The overhead of =
TLB
>>>>>> shooting down is high, so it's better to be avoided if possible.  =
In
>>>>>> fact, if we delay mapping the page in PTE until migration, that =
can be
>>>>>> avoided.  This is what this patch doing.
>>>>>>=20
>>>>>=20
>>>>> Why would the overhead be high? It was previously inaccessibly so =
it's
>>>>> only parallel accesses making forward progress that trigger the =
need
>>>>> for a flush.
>>>>=20
>>>> Sorry, I don't understand this.  Although the page is inaccessible, =
the
>>>> threads may access other pages, so TLB flushing is still necessary.
>>>>=20
>>>=20
>>> You assert the overhead of TLB shootdown is high and yes, it can be
>>> very high but you also said "the benchmark score has no visible =
changes"
>>> indicating the TLB shootdown cost is not a major problem for the =
workload.
>>> It does not mean we should ignore it though.
>>=20
>> If you are looking for a benchmark that is negatively affected by =
NUMA
>> balancing, then IIRC Parsec???s dedup is such a workload. [1]
>>=20
>=20
> Few questions;
>=20
> Is Parsec imparied due to NUMA balancing in general or due to TLB
> shootdowns specifically?

TLB shootdowns specifically.

>=20
> Are you using "gcc-pthreads" for parallelisation and the "native" size
> for Parsec?

native as it is the biggest workload, so it is most apparent with
native. I don=E2=80=99t remember that I played with the threading model
parameters.

>=20
> Is there any specific thread count that matters either in
> absolute terms or as a precentage of online CPUs?

IIRC, when thread count matches the CPU numbers (or perhaps
slightly lower), the impact is the greatest.


--Apple-Mail=_893D95E3-DB07-4148-AC61-E60F3DABEC09
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBmHUoACgkQHaAqSaba
D1p2fw//RAgsNKT5ss22mo08un176bYzRehM82EXzJjDeWXcHhEFVAPpXUMpRXo+
2XNjGtHHBHvGbXoNwGQN/O0W6g3Q3pFnW78G0RE8e7zLBKj6lALPIBcP/+tDvUCc
tY2Fhj4BqMZ6O18C8UXJqrxSPAqCGzvF+VjavZ/XUQVDlzB70c0B+i85vMXD8kGq
JgwBhhyDnHcTToDm1bG7GMLGUcYJZEcGEA4KP0EdUjSOQLkt+/0/r+We9zFsDInV
9LfSo+aMFTzRPLj++TrF278VJU+GiEjkRJ9DLlojty7c6whsQvJS6vhDPYTCwkT0
NSuNGknPEnXJVpeg0hc3lmwYTgRk3RDr1CKbgGoVCKlFCdNlwX4BlEBfcaoMcftC
7tvasSgIWfbHNdHHKopAFJS1KEmoJaBgIxCADwBVECZB5LEYnJTim7FrmipS7ASI
+tP1+VRRytvTeZteOjDi/9FF8izExQ4WB+64ot2a1EdoC2y3njmhkeWuOLOiRVaQ
EH+o4PWGTUlAalvV5K/tDTrpX5ywPhr0QKskMlXKCcoXmcHPNQmo6Nb1hvjQ6lFn
Ov3lNhltdfeL9YJPPC5WBQAGiA6HSjMzBCaQpLuGtssQbjG4TKTbAtEhqyw0JEA2
5PQDdHvyYQi8USwlnsvkCOu2PKJDM2OudeJybW9kVsmJSK9LjwU=
=MMz9
-----END PGP SIGNATURE-----

--Apple-Mail=_893D95E3-DB07-4148-AC61-E60F3DABEC09--
