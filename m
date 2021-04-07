Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5E356E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhDGOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:14:14 -0400
Received: from verein.lst.de ([213.95.11.211]:59521 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243083AbhDGOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:14:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A0CA68C4E; Wed,  7 Apr 2021 16:14:00 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:13:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] binfmt_flat: allow not offsetting data start
Message-ID: <20210407141359.GA19843@lst.de>
References: <20210407115638.1055824-1-damien.lemoal@wdc.com> <20210407115638.1055824-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407115638.1055824-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:56:37PM +0900, Damien Le Moal wrote:
> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
> the data start"") restored offsetting the start of the data section by
> a number of words defined by MAX_SHARED_LIBS. As a result, since
> MAX_SHARED_LIBS is never 0, a gap between the text and data sections
> always exist. For architecture which cannot support a such gap between
> the text and data sections (e.g. riscv nommu), flat binary programs
> cannot be executed.
> 
> To allow an architecture to request contiguous text and data sections,
> introduce the macro FLAT_TEXT_DATA_NO_GAP which can be defined by the
> architecture in its asm/flat.h file. With this change, the macro
> DATA_GAP_WORDS is conditionally defined in binfmt_flat.c to
> MAX_SHARED_LIBS for architectures tolerating the gap
> (FLAT_TEXT_DATA_NO_GAP undefined case) and to 0 when
> FLAT_TEXT_DATA_NO_GAP is defined. DATA_GAP_WORDS is used in
> load_flat_file() to calculate the data section length and start
> position.
> 
> The definition of FLAT_TEXT_DATA_NO_GAP by an architecture also
> prevents the use of the separate text/data load case (when
> FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU kernels).

Please make this a CONFIG_* option selected by the architecture,
which also allows to use IS_ENABLED() to error out early for
your check.
