Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06FF3D59BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhGZMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhGZMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:06:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097FC0617A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YnYb8vRrXr3FxlNbM7BmLabWx+TSAadNbGAbdiZoOjA=; b=A1iU3VboJ6FOB2nV65zruUFHye
        3IRBDvTt4YJWQRJtChVduRiQcjsa78Imto78cOV/HAQpQ9WrfndEQE71hjNiA6Tf/jh0LJvQtF3Ea
        MoO4djcVS2Szb1lVU7k7IKpyO+iJZ4oWfses1AZ05UJQJy68+i9bWCVytGOBFh/iIeJg+bSZ+jHyk
        5LiAGbsilJ1P2D8TfSsB03woWu3EH2ljle5uOT7EAwF1U6xR6URAygQscUZ2Q0K3YbQ99jAv53m8n
        RH+tJ6dsxe50F/w9HiNZraSfBIzZ9jUiaxh6QZNSxpTJUBgF9TTAzNmCUm0i+fOSentrW5Jvh7mxH
        VduRG/7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7zzI-00DxU2-AC; Mon, 26 Jul 2021 12:46:06 +0000
Date:   Mon, 26 Jul 2021 13:45:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+bb4c69145b4a52b40b27@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 folio_copy
Message-ID: <YP6udKVlejbnTOiw@casper.infradead.org>
References: <000000000000f84cad05c7ee4778@google.com>
 <20210725221834.35e077daff0005f3d78d08d7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725221834.35e077daff0005f3d78d08d7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 10:18:34PM -0700, Andrew Morton wrote:
> (Cc Matthew)
> 
> (It might not be a folio thing at all - I haven't checked yet)

Already fixed, thanks.  folio_copy() had a cond_resched() in it,
even if it was only copying a single page.  Now it only calls
cond_resched() if it's copying more than one page.

We discussed this in the folio call on Friday, because we're leaving a
bit of a landmine here for whoever tries to make multi-page folios work
with buffer_heads.  There's not much we can do about it for now; it'll
just be one of the many problems to be dealt with.  Hopefully filesystems
will convert to iomap instead of trying to make buffer_heads support
multiple pages.
