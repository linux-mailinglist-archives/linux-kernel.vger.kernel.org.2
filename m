Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9452F3EE62F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhHQFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:20:39 -0400
Received: from verein.lst.de ([213.95.11.211]:57087 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQFUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:20:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 533D567354; Tue, 17 Aug 2021 07:20:04 +0200 (CEST)
Date:   Tue, 17 Aug 2021 07:20:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: Re: remove set_fs() for h8300
Message-ID: <20210817052003.GA4595@lst.de>
References: <20210709115311.3424912-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709115311.3424912-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 01:53:09PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes support for the deprecated set_fs address space
> override on h8300.  Because h8300 doesn't actually have different
> address spaces to start with as a pure nommu port the changes are
> pretty simple.
> 
> Compile tested only.

Any comments?
