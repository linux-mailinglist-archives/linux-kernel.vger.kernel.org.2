Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459D3C9A22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhGOIKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhGOIKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:10:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F4FB61362;
        Thu, 15 Jul 2021 08:07:40 +0000 (UTC)
Date:   Thu, 15 Jul 2021 10:07:38 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] binderfs: add support for feature files
Message-ID: <20210715080738.oumkwhbcz7lxej65@wittgenstein>
References: <20210707162419.15510-1-cmllamas@google.com>
 <20210715031805.1725878-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210715031805.1725878-1-cmllamas@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:18:03AM +0000, Carlos Llamas wrote:
> Provide userspace with a mechanism to discover features supported by
> the binder driver to refrain from using any unsupported ones in the
> first place. Starting with "oneway_spam_detection" only new features
> are to be listed under binderfs and all previous ones are assumed to
> be supported.
> 
> Assuming an instance of binderfs has been mounted at /dev/binderfs,
> binder feature files can be found under /dev/binderfs/features/.
> Usage example:
> 
>   $ mkdir /dev/binderfs
>   $ mount -t binder binder /dev/binderfs
>   $ cat /dev/binderfs/features/oneway_spam_detection
>   1
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
