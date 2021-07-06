Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5F3BD8AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhGFOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhGFOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:45:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A483C0613B0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=udC4bV41BbsNIKVpy6ic/da3W1ocJE3n3LRrN8sz7S8=; b=FjTBFZNITc0vkmUP6jtixeQCbo
        dubn0BzCY8phmoMoRl2xAPJc14BGr9T6fReSwCBvH/qB0WBfsYNadwQccmINVE3zsujV+ATV8M1Df
        qhoP/v6CO28kaWdwhC04n1UR7yXbTYMCyxrKzqLsvm2ZtvuZOV5ZsMeib20dwowBj5tKXHHh+GbOa
        VRsM2E+Ba1WOFn0hHYZ2hFa2PB56uE11UPPddJxWtZP2vPlcdkSuMDJtvWgjnRyr5LW0xJ9RuKZHH
        HfUqwxSzTPpbZxfgel6DEChTTqRRq0qHeGaQieFIIZQ9aCH9gOp+bKOR9SN/Zu0ZzaLeR3lPyAt9r
        ioo01zug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0m7r-00BShB-1r; Tue, 06 Jul 2021 14:32:42 +0000
Date:   Tue, 6 Jul 2021 15:32:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH 1/2] tools: Remove lockdep.h and its include from
 spinlock.h
Message-ID: <YORph8YRsIzgoPj4@casper.infradead.org>
References: <20210706142632.670483-1-eperezma@redhat.com>
 <20210706142632.670483-2-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706142632.670483-2-eperezma@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 04:26:31PM +0200, Eugenio Pérez wrote:
> Commit 58d6ea3085f2 ("xarray: Add XArray unconditional store
> operations") adds this file at the same time that xarray and xarray
> tests. However, xarray tests and other tools/ works with no problem
> without this file.
> 
> The motivation for the deletion is that vhost tests/tools need to use
> spinlock.h mock file, but at the moment it includes lockdep.h that is
> only available under tools/testing/radix-tree.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
