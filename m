Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A150B4466AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhKEQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhKEQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:08:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BCC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/QhuuabOUTi2MiOmb9yxPw8ZTDvtRhXTVEJT6rYv16s=; b=MOyv1yOpsSjBtnmvY4/Nrxut12
        k7CJLfYZbfHJQncE/JG0ljnFvn+GVeaGgQXzTjyGwGmy0oi0kZUjNAHHOhqUw8ntrOjjzJfrN0Zps
        CUh1KMEdOEMvUW8aXxfP9fDS3zCCYiBJZJtohUll7SqivMh6nBop1WGhLdaPwKMpOom7H3AMIk4Cy
        gIT0/PhgFKRptwo1lyRKAsd/GE6Hhd0it2rW+XYwQ74aEnzW4ddmIi3WsCyQVVEqQ/QhH/EM5Ze1t
        d8KV0AtoLvGl2U3Bg9O5K9xlzs7K9WrgpgwfpXh7TRDGRJiH7CHqqyNEZUZUvoRiy830RlaYVn/wX
        ePLSFo4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj1iY-00Bttw-FG; Fri, 05 Nov 2021 16:05:26 +0000
Date:   Fri, 5 Nov 2021 09:05:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, neilb@suse.de,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: simplify sget_fc() call
Message-ID: <YYVWRizOWD5MNMCE@bombadil.infradead.org>
References: <20210726202253.2226788-1-mcgrof@kernel.org>
 <YXNGDPMRD+K6nmCu@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXNGDPMRD+K6nmCu@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:15:24PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 26, 2021 at 01:22:53PM -0700, Luis Chamberlain wrote:
> > We can just use set_anon_super_fc(), no need for our own
> > custom implementation of something we already have available.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> *poke*

*re-poke*

  Luis
