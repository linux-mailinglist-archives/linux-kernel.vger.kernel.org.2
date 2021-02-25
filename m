Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C1324B59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhBYHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhBYHf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:35:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72C6164E85;
        Thu, 25 Feb 2021 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614238479;
        bh=fCo4630llG1h78vVNDcLgazcjDfv48yQtx8UMOFjzGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIXpOLzX0O9vSF5/eAHd907IggebEqg0JMZ5gsMa2888wD/TrolmVlYPBxL0I1Hur
         YgWLHvQ0z5rciE9uHyQ7cvhDWYP+oOv4RsejGsh5c/VQBsAinuj4akDGFt8d5OUDmT
         TqM03SGm5dRel1KYUaon98TfokNiLyWrdO2rDZyJ3kUeCBeqAavyVGlOkicbfEfoIm
         Y4AqjOG4n+p8TTBKhzSLqWzM/1BSlmSIaZrWaSd7z+Wcq/OgxFEMmOmp7PIPp3+t8j
         q/vpzLwJ8S0uHpMCp2wqMdVz8dz6C2semR13RM12uFmizqe9fvcgp4xFwCibzZFodZ
         KoIorIEe8dWqA==
Date:   Thu, 25 Feb 2021 09:34:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     haitao.huang@intel.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/3] Introduce version array structure: sgx_va
Message-ID: <YDdS/WHqu7y9piie@kernel.org>
References: <20210224222049.240754-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224222049.240754-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:20:46AM +0200, Jarkko Sakkinen wrote:
> Introduce an xarray based version array (VA) structure: struct sgx_va.
> 
> The use of sgx_va can be later on extended to the following use cases:
> 
> - A global VA for reclaimed SECS pages.
> - A global VA for reclaimed VA pages.
> 
> Testing done while developing the patch:
> 
> - With NUC7PJYH: https://www.intel.com/content/www/us/en/products/boards-kits/nuc/kits/nuc7pjyh.html
> - seq 10000 | xargs -I {} -P10000 ./test_sgx > /dev/null
> - The EPC size was set from BIOS to 32 MB.

In [1], 'va' branch is tip/master with the patch set on top.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git:

/Jarkko
