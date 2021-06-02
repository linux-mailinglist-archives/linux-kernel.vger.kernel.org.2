Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A93984B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhFBI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhFBI65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:58:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB82B613D5;
        Wed,  2 Jun 2021 08:57:12 +0000 (UTC)
Date:   Wed, 2 Jun 2021 10:57:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] proc: Add .gitignore for proc-subset-pid selftest
Message-ID: <20210602085710.kp26wquy6anwy5kd@wittgenstein>
References: <20210601164305.11776-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210601164305.11776-1-dmatlack@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:43:05PM +0000, David Matlack wrote:
> This new selftest needs an entry in the .gitignore file otherwise git
> will try to track the binary.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---

Could use a
Cc: stable@kernel.org
link but Shuah might be able to fix this when applying.

Otherwise looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
