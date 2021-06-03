Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FD39A91A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFCR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA72C61242;
        Thu,  3 Jun 2021 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741074;
        bh=3Ej7uK16xlMwmlQVPnPvIEj9+RNCEzhGFDhBsfYGNzw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cGXwQp7pbUSwNbLyS1MKieTmCw60SX6Y1/Sq/F/Wn1CjKWnCEMgfmuHbAHkybD7Mu
         5XfjWlIwD5YSMtSVYBlsPWZVCV5iTzmf02dx30Ghpqv1DZJdwcweHSeCDBuwZSYplp
         jEmjcxXddgDmIympblyYO2ykrCOrtcBbMAN4MCxedpWxmhMV7a0apVCSf7vasBgUwG
         osyTMn8YBx9rBJQuCFNFsj+X1czPpMhi8mCNJILoDcku1Kj1UVjhcnjkyoz4k4Uu0u
         0YGfEPl+KZ82N5R6IK+qv0rTrNjvehUCfSs0khYjYneUcpJW9ChakC5Tj8ritM9N2Q
         h8rrbJq8Y8xSg==
Subject: Re: [patch 5/8] x86/fpu: Sanitize xstateregs_set()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20210602095543.149814064@linutronix.de>
 <20210602101618.851242793@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b9074b29-bc0e-6717-78c2-8b08fd008dbc@kernel.org>
Date:   Thu, 3 Jun 2021 10:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602101618.851242793@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 2:55 AM, Thomas Gleixner wrote:
> That's just wrong. The caller supplied invalid data or has a problem with
> unmapped memory, so there is absolutely no justification to wreckage the
> target.
> 

"Wreckage" is a delightful word, but it likes to be a noun.  One can
wreak the target, wreak havoc upon the target, annihilate the target, or
turn the target's state into system-destroying wreckage :)

--Andy
