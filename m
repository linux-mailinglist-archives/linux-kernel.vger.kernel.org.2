Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5D32A3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382585AbhCBJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:40:03 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:38120 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838099AbhCBJTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:19:18 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 576ABB00626; Tue,  2 Mar 2021 10:09:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 56A00B0061E;
        Tue,  2 Mar 2021 10:09:10 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:09:10 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Yejune Deng <yejune.deng@gmail.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/slab.h: use for() and left shift to
 calculate
In-Reply-To: <20210302033908.51706-1-yejune.deng@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103021007490.860725@gentwo.de>
References: <20210302033908.51706-1-yejune.deng@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021, Yejune Deng wrote:

> use for() and left shift to calculate the value that compared with size.

There is a reason for the madness...

The current code was written so compilers can do proper constant folding
and eliminate the whole function entirely.

If you want this change then please verify that all compilers currently in
use with this code do proper constant folding and never generate code for
the for loop.
