Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7623165EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBJMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:03:28 -0500
Received: from verein.lst.de ([213.95.11.211]:50717 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhBJMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:00:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8D9D68B02; Wed, 10 Feb 2021 12:59:53 +0100 (CET)
Date:   Wed, 10 Feb 2021 12:59:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] module: potential uninitialized return in
 module_kallsyms_on_each_symbol()
Message-ID: <20210210115953.GA28552@lst.de>
References: <YCO8AwE57IzaMamG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCO8AwE57IzaMamG@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
