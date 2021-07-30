Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746D3DB063
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhG3AmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3AmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F59160F0F;
        Fri, 30 Jul 2021 00:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627605728;
        bh=fzQouAp0BSmpfI0BisnWIRifzAAL6fkGAKQxzXLpDis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVV1c9N8Sv3Agke1azj+JnVRpRHWnJNLlG0u3fWIWc0fk+f4lWqOtX4OtLhXXI9FO
         QHzn9bxnmZ9MjHU/jC+VBqFK/2s3gV9JmHy/iU918sF2pIJVYmdMYm7gLF+JOCW8P9
         Azkpb7nkbiCQww34/VweHP0p+po6QUXz58mmySOFb5U0N2yyAqXnjzwEqj9NZYVTCi
         QPabGQqgE23k12xplgJAYHcagBSc5B5EA1Kk10B6CfDQUAho0WhCvHOMJ4NiGOK7FC
         B5ijp43zrcIv7gLqIqmq9v+bV0JhqqlONP3S8xMMl9xzd4vkFpSUfEJe84MRp+Xwvq
         KtMHeKK4KaZCw==
Date:   Fri, 30 Jul 2021 03:42:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] x86/sgx: Initial poison handling for dirty and
 free pages
Message-ID: <20210730004204.cwlb6lm5e7rabgio@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728204653.1509010-4-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:46:49PM -0700, Tony Luck wrote:
> +	dir = debugfs_create_dir("sgx", NULL);

dir = debugfs_create_dir("sgx", arch_debugfs_dir);

/Jarkko
