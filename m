Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FF33FDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCRDP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:15:58 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:15635 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCRDPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:15:54 -0400
X-AuditID: 0a580157-463ff70000021a79-a6-6052bf0b35bc
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 9B.2F.06777.B0FB2506; Thu, 18 Mar 2021 10:46:35 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 18 Mar
 2021 11:15:51 +0800
Date:   Thu, 18 Mar 2021 11:15:46 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm/gup: check page posion status for coredump.
Message-ID: <20210318111546.4bda8c7a@alex-virtual-machine>
In-Reply-To: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXCFcGooMu9PyjB4OAHJYs569ewWXxd/4vZ
        4vKuOWwW99b8Z7X4uD/Y4mLjAUaLM9OKHNg9Nn2axO5xYsZvFo8XVzeyeHx8eovF4/2+q2we
        m09Xe3zeJBfAHsVlk5Kak1mWWqRvl8CV0fX0BmvBUvaKzjvrmRoY97J2MXJySAiYSOy495mx
        i5GLQ0hgOpPE7v2LmSGcV4wSczu3snQxcnCwCKhKHDivC9LABmTuujcLrFlEQENiU9sGsHpm
        gT4miY6VR1hAEsICzhKbj89kBrF5Bawkvj97zQ5icwrYSfz5dJARxBYSyJNY/GwpG4jNLyAm
        0XvlPxPERfYSbVsWMUL0CkqcnPkEbCazgI7EiVXHmCFseYntb+cwQ8xRlDi85Bc7RK+SxJHu
        GWwQdqzEsnmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdcBMjJDbCdzDOa/qod4iRiYPxEKME
        B7OSCK9pXkCCEG9KYmVValF+fFFpTmrxIUZpDhYlcV6RKKCUQHpiSWp2ampBahFMlomDU6qB
        yc14wdWtbUWLVumlPGTOvHZJmlH6tmfmoxmL33tbdhWLTX6xxHLeU4u/2yZ+mHaW6bJVWpSm
        W1mWcI/t9skSKz3d0p3cNh+50hiYLhf6Rbeqbu7eQ+UdE8SXWcTmS1zMCvolk3s2TuWXRlvr
        p3jGd8E8V8KNJxTYGd76se+Oxs9H6QIMx+cpl24pmDf38M0vwfPemm+/pxzcbNt98kL/+aPX
        jGaFvFpzMdi80fLAseMn4j0ZuTo/yVz6/HX+s8PykalfpGax3Vfbe3pW07olBdxn1q6xm/r3
        neOzrYmV37/vY7tuuzSqjeGfs+Uq5U7f9OkcYT3Fc0T1tq1+sEXDpVRra/Bxbd8wXvVHk6q/
        1iuxFGckGmoxFxUnAgBTk1IU/AIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 10:12:02 +0100
David Hildenbrand <david@redhat.com> wrote:

> 
> I wonder if a simple
> 
> if (PageHWPoison(compound_head(page)))
> 	ret = 0;
> 
> won't suffice. But I guess the "issue" is compound pages that are not 
> huge pages or transparent huge pages.

Yes, the simple case won't suffice, as we mark the hugetlb page poison in head, and
other cases in the specific single page struct.

> If not, we certainly want a wrapper for that magic, otherwise we have to 
> replicate the same logic all over the place.
> 
> > +
> >   	return (ret == 1) ? page : NULL;
> >   }
> >   #endif /* CONFIG_ELF_CORE */
> >   
> 
> 

Yes, May other places meet the requirements as the coredump meets, it's better to make a
wrapper for this. But i am not familiar with the specific scenario, so this patch only cover
the coredump case.

I will post a v2 patch for this.

-- 
Thanks!
Aili Yao
