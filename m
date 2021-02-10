Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD49A316AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhBJQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232062AbhBJQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:18:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D5BE64E76;
        Wed, 10 Feb 2021 16:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612973880;
        bh=z11X40ByBwLWoBHw1+NfChx4CZeIHFtuXrvlkGJQ3Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Elq8p36WSo3O9tH0kKFOe6CvIQ9iHj6UkuGTWwI2LlVyzXqa5v02hTGBeqbZkNzRG
         2Pcpf1aYrNXOPOTPhrfdc9Z9JArg9Icx5yg+4Mua8Qbo5R7AmaoGRn9W0ZC0E3M9Oc
         oaYs8KWoTjp/AVcH6WhlXg1sgLSiVj+VMURLENI3SHb0sx2L4t6xYaHddcbxzxODn5
         L2qBgs6yk+tKh/ShCvryuQrA19piAZA8N43oKyHwXWgk+nF9vIRN62hlr/YwpACF84
         k5WYJUbYLdicclku6tU8UMv3j9jciAgFE4KJwFcxApvij1BRJhbekaI+P179/6c0MJ
         yHZJU3z7aklMQ==
Date:   Wed, 10 Feb 2021 17:17:56 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] module: potential uninitialized return in
 module_kallsyms_on_each_symbol()
Message-ID: <YCQHNI3bowhhnRD+@gunter>
References: <YCO8AwE57IzaMamG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCO8AwE57IzaMamG@mwanda>
X-OS:   Linux gunter 5.10.12-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Dan Carpenter [10/02/21 13:57 +0300]:
>Smatch complains that:
>
>	kernel/module.c:4472 module_kallsyms_on_each_symbol()
>        error: uninitialized symbol 'ret'.
>
>This warning looks like it could be correct if the &modules list is
>empty.
>
>Fixes: 013c1667cf78 ("kallsyms: refactor {,module_}kallsyms_on_each_symbol")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!

Jessica
