Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635A23F2C30
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhHTMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:34:48 -0400
Received: from ozlabs.org ([203.11.71.1]:43873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240538AbhHTMeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:34:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Grgzv3Qhxz9sWq;
        Fri, 20 Aug 2021 22:34:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629462845;
        bh=RvSoZj9qGbuGPBLusBDgZESowYHwhMMiBJyC8aIMk60=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mtQUVDWVN21fl7CB8Gv+bXzF4FyNyW44mL2BYz7qsbt/eYeNT69e584cR6zMVbxqO
         ynl5XZWnLQ45izhHFGBbzG1riwSDXF5HxR7P6MYnAHHiOX2/bE53XIUnaRqRJMDFAm
         P8zAFSBs7KWapWa9nTnuKg/KNnO3bZ2mOUawCw+CDy+9UnJXlCv1wJXqDWlnNolPaB
         rXl1Ck3kKrE+EXgUNuoH0szMYFn4EqkJTs0hQNEXiHpEp16L82OBAnWkCq19clUSEG
         6/9GTOU9oqC5kGb9R5dOO/Mh4wDbKHUsiboA1eolxLil/INGfzViLXj4lvJnbxaRGw
         0qe92o3jgy8cw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 2/3] tty: hvc: pass DMA capable memory to put_chars()
In-Reply-To: <87pmu8ehkk.fsf@linkitivity.dja.id.au>
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
 <20210818082122.166881-3-xianting.tian@linux.alibaba.com>
 <87pmu8ehkk.fsf@linkitivity.dja.id.au>
Date:   Fri, 20 Aug 2021 22:34:02 +1000
Message-ID: <87pmu8cn2d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Xianting Tian <xianting.tian@linux.alibaba.com> writes:
>
>> As well known, hvc backend driver(eg, virtio-console) can register its
>> operations to hvc framework. The operations can contain put_chars(),
>> get_chars() and so on.
>>
>> Some hvc backend may do dma in its operations. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>
> We could also run into issues on powerpc where Andrew is working on
> adding vmap-stack but the opal hvc driver assumes that it is passed a
> buffer which is not in vmalloc space but in the linear mapping.

The right fix for that is our code that calls opal has to be careful
that it's not passing vmalloc addresses.

We have many cases where we pass stack variables to opal, they'll all
have to be fixed to pass the underlying phyiscal/linear map address. The
opal hvc code will just be one more case of that.

cheers
