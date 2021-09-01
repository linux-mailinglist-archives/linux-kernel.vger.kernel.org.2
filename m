Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15F3FD610
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbhIAI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:58:23 -0400
Received: from lb1.peda.net ([130.234.6.152]:28803 "EHLO lb1.peda.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243138AbhIAI6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:58:18 -0400
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb1.peda.net (Postfix) with ESMTPSA id 7C986600004;
        Wed,  1 Sep 2021 11:57:19 +0300 (EEST)
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
To:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
 <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
 <YSzuLbHr7fHshafX@casper.infradead.org>
 <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
 <YS0Eq+tNe4Pr7O0X@casper.infradead.org>
 <0cdd0624-fcc3-386e-c651-7173dc3cbb59@peda.net>
Message-ID: <9fe84f08-52a6-0ed0-c4cc-639f31f9b7f5@peda.net>
Date:   Wed, 1 Sep 2021 11:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0cdd0624-fcc3-386e-c651-7173dc3cbb59@peda.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikko Rantalainen (2021-08-30 20:26 Europe/Helsinki):
> Of course one possible solution is to keep "Cached" as is and introduce
> "Cache" with the real cache semantics (that is, it includes sum of
> (Cached - Shmem) and memory backed RAM).

That should have been "swap backed RAM", of course.

