Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655953A5F53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhFNJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:46:29 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40669 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232630AbhFNJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:46:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 955AA1758;
        Mon, 14 Jun 2021 05:44:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 14 Jun 2021 05:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=k
        P7GTrlZ1Lv8pbIRCpbLNMCW525kd0MX52U2JVhGjrY=; b=hA3yhHVusaaIadWQi
        7lPU3Pu8Li2SH9oSGCcpWN0FHq6IunJ2mZHAWMNav+jK5Q6Yj8IsUxj3dufKGhwV
        oFP0qJu1oU8d8xv2fKtw70cSHRngG5pVMF4oU7SiY2efLk7z7UNbEBHcdsKMTFEm
        AEB5FCp1dSbBnKHm5+gP8a2t8Wl6hj8XJ6+YOvu7jobQEw4+cCUKAilH9OcaS5fO
        Ux4NjDxI7GayEjbJHXhs/bLlKLRhoJiNbLBfRdTzdzyhiEu1kUmhkJf9XlhVv+rC
        AfpfBeSIHnctvPnbN5/2mbt2gr++IwRwN/WGqSEE+vfM+1yMhk750Y1EYsoCUwr4
        vXJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=kP7GTrlZ1Lv8pbIRCpbLNMCW525kd0MX52U2JVhGj
        rY=; b=QpzupR4ZQ35Jk6Q3cWChtS2E9D3/UnZzdw0XZLZXi2++31nfvxLyn1O+Y
        lSuNmut0Qrikvc//ylHfNUrQB+7bG2jOQ+vdbZPeDnhAAb65P5w3v8F8Nct+6EC6
        vjl4fM4MDZ8cyv4iH/wwcZIHpqkqJRDW0sgpG38+Ux7vGxFtbRVK9vOHpvwfod0+
        st04M5oakWyukaEve0GIMlIu08AZ4M7TZDn14qFZ5I9bnphlykCfeSMsNzhxntXx
        r2z2z0onkVHSTYh5uR6L91eKoy6EzxJd8u2Lvy0JPURy8Bn6yhfZ9Qq8lYQL9qt9
        YmeE/lQixrPVAfzTaIe5zkaTFR+6g==
X-ME-Sender: <xms:8STHYKVZpnKdT-sk6gcsTQ0oHhaO2AHzDGKE9mT5vwFPaG1cD6ihmw>
    <xme:8STHYGmFcEf9ljwyC0M1dfd2tRNhwuTEBQssX7zpSkdMuyUeVmPIYGghD3AUYB6ao
    VQ39h_2XtidiA>
X-ME-Received: <xmr:8STHYOZ78YRB0SwLrlDaKRB4C7DOoZ5Xep2yti0If3dTb9q1Lgy_cbNFeG2naW-NgDSqmi2y5-cAY00BPazB9eILX1rzzkyq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeevtdeileeuteeggefgueefhfevgfdttefgtefgtddvge
    ejheeiuddvtdekffehffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:8STHYBXRDYEqP1sZzaTfw9OKa58FkReJZBcL7jte8NSQfjZBXVXwgg>
    <xmx:8STHYEmoWo7MMcgjfIk1e0uSNycTIgH9EeooR5w_evVBa6Kynj_-yw>
    <xmx:8STHYGfZ_QG9ys0Ct3igIkS5y2s2wpWyHJ8x81nxXKbkr-6WuV2BFQ>
    <xmx:9CTHYCR4YjRHr64xQXGh2Poy4Ebbuh1gZFUBwI49nM4hwWf3WLVTvkmVpJU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jun 2021 05:44:16 -0400 (EDT)
Date:   Mon, 14 Jun 2021 11:44:14 +0200
From:   Greg KH <greg@kroah.com>
To:     sieberf@amazon.com
Cc:     sj38.park@gmail.com, Jonathan.Cameron@huawei.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        linux-damon@amazon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sjpark@amazon.de, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v29 09/13] mm/damon/dbgfs: Support multiple contexts
Message-ID: <YMck7uUlSvqFqJZH@kroah.com>
References: <20210520075629.4332-10-sj38.park@gmail.com>
 <98a75d0c-2d1a-807e-050b-fb8e7d92f447@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a75d0c-2d1a-807e-050b-fb8e7d92f447@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:30:12AM +0200, sieberf@amazon.com wrote:
> +    new_dir = debugfs_create_dir(name, root);
> +    dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;
> 
> debugfs_create_dir might return ERR_PTR, should this be checked?

No.  Why do you care, the logic will keep on working afterward even if
that were to happen.

thanks,

greg k-h
