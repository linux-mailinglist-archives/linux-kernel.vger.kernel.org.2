Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6063C9A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhGOIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235749AbhGOIMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10EAE610D1;
        Thu, 15 Jul 2021 08:09:17 +0000 (UTC)
Date:   Thu, 15 Jul 2021 10:09:15 +0200
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
Subject: Re: [PATCH v2 3/3] selftests/binderfs: add test for feature files
Message-ID: <20210715080915.xpizwkzxp2irthvu@wittgenstein>
References: <20210707162419.15510-1-cmllamas@google.com>
 <20210715031805.1725878-1-cmllamas@google.com>
 <20210715031805.1725878-3-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210715031805.1725878-3-cmllamas@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 03:18:05AM +0000, Carlos Llamas wrote:
> Verify that feature files are created successfully after mounting a
> binderfs instance. Note that only "oneway_spam_detection" feature is
> tested with this patch as it is currently the only feature listed.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
