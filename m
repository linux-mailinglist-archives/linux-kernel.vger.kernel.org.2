Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0743DD1DE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhHBIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232562AbhHBIYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6BD260C3F;
        Mon,  2 Aug 2021 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627892655;
        bh=3sBZuGcqa5zZQrmYaUNrUR9Q6XMM3QzfBhTtZ4vnpN8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Gt0kYirSlHEWaaFzsGCuJIGckzIP9Q6G351n3Gz9Fwzu5xVNXOX1xVGQBaoBm8rhg
         et2sfe9MtPNIq5K6rmxKPIXyhK4nQLGkVojOp5JhF/6ziA4pjcarldLtag0ITsi+Wr
         NZ4gQkSrLI3cCxu6Z6c+nHzVmH8K0kJSWNUtkgUPPez2gCa+UHaknnOtajxZzjt0Fj
         +mggSQXzGNdID8Y6YcaxkOgpc5JWgfNTmLJB6C3wkUFHyx60hmj5BNmx43deJqaBlZ
         6hlvMjXUuQUKJJDcjJSZkNRbtX9k59spxU8mWL382lTWiQ6zrPsWif87pstXDUxyuq
         HmaOBwj0o6G9w==
References: <20210801055454.53015-1-jj251510319013@gmail.com>
User-agent: mu4e 1.6.0; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] usb: gadget: Fix inconsistent indent
Date:   Mon, 02 Aug 2021 11:24:01 +0300
In-reply-to: <20210801055454.53015-1-jj251510319013@gmail.com>
Message-ID: <87a6m0s18z.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wei Ming Chen <jj251510319013@gmail.com> writes:

> Remove whitespace and use tab as indent
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
