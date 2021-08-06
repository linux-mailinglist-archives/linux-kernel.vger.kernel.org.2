Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A8A3E2BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhHFNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:49:05 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40706 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHFNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:48:58 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC0DG-007dY8-OT; Fri, 06 Aug 2021 13:48:38 +0000
Date:   Fri, 6 Aug 2021 13:48:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: optimise generic_file_read_iter
Message-ID: <YQ09tqMda2ke2qHy@zeniv-ca.linux.org.uk>
References: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bd408d6cad95166b776911823b40044160b434.1628248975.git.asml.silence@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:42:43PM +0100, Pavel Begunkov wrote:
> Unless direct I/O path of generic_file_read_iter() ended up with an
> error or a short read, it doesn't use inode. So, load inode and size
> later, only when they're needed. This cuts two memory reads and also
> imrpoves code generation, e.g. loads from stack.

... and the same question here.

> NOTE: as a side effect, it reads inode->i_size after ->direct_IO(), and
> I'm not sure whether that's valid, so would be great to get feedback
> from someone who knows better.

Ought to be safe, I think, but again, how much effect have you observed
from the patch?
