Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02E9430A01
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhJQP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhJQP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:28:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35830C06161C;
        Sun, 17 Oct 2021 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=70ZKfllBjZHQa1J4GUObwLCze3CU8wCeQiJAaBSPZwY=; b=C4UNljiRQnxqpGr/gZae9CnIWT
        j7Uyl2yYks8L0q03i4Yj6wzbXHZfLRSnndsp7bwE+G+8kSeY6JWp3qOqYzPXZm7xgouB3Y3hUQhtB
        Pk4Hz6DQ4fJj9JpSQmWL3lPFrfCQD6hkq6x6Rwnt4SbkGg8suXrp9MdS/9GwqmQ6jlHlFEgk2ZXtF
        TIxTzVAunQ+vPdosDdlLDCl2JNMPGbY3ukZHFD5HB/10NLbW6nDO6fT48v5VJRLhpzgc3wB6XGEom
        dyYnzfPdzBD/IPULfN37GdDBH1ku04zKJuWqNo9uyCNES4imNkH0NlqGgJMRJ5knyNRf5ELnaJOvh
        Cfc6kr6w==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mc83d-00ANfc-5J; Sun, 17 Oct 2021 15:26:41 +0000
Subject: Re: [PATCH 00/13] block: add_disk() error handling stragglers
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        jim@jtan.com, minchan@kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015235219.2191207-1-mcgrof@kernel.org>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <a31970d6-8631-9d9d-a36f-8f4fcebfb1e6@infradead.org>
Date:   Sun, 17 Oct 2021 08:26:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 10/15/21 4:52 PM, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.

Do you have a git repo with the patch set applied that I can use to test with?

Thanks.

-Geoff
