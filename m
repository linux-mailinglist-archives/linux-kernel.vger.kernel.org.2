Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083FF419158
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhI0JNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhI0JNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:13:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236D6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:11:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b20so74565926lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjdgfNID1F56pN/ToVuugx7UPq8+diudyxoBfhqPDek=;
        b=CZ0INnd+an0mI0YdfzuS/n5CtlqpiQBbC3XKcsLZ6DET1fsm18OachI2raiJmeEDZn
         mo2U8zBEjNExo9Bfm/u8YK2XOajIDPBbTzwblyvny/q2O/Ns4eFcU9ctYWg+BvZTxXxQ
         4BQQDihSMkbr6f+DY31NKdXMMac3XLQQ7O5oOxyFbKHjfCqU+5aLHJDQMIaQ4nVsgjyQ
         awRjzp57HaD0/hZ56iHukLLMdysVUvUCrlPVxQQBSt+7eh2HKG/ejW5LWfT2WrGpDaWH
         QNMxbKmPrDZzF4s9CE4h9PvmjtaVeQ1hx5Fo7zHQPqv3hIaXv6INnP/EoHbwBBU7jwc0
         EYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjdgfNID1F56pN/ToVuugx7UPq8+diudyxoBfhqPDek=;
        b=LERTEBW49RlCk7OGSroXHRcZj8UfXddHParMQFCejMflBe4M7cBBEh96jFlEdVL5+H
         zFvbIrt+JO/OzRRjjKWhBDYJGl4+cdrw7+I2fAiAFP7aFiApvktLp/cb5eOtG+GhGSl8
         VQHTM3Cd/fvm1TJeM4NUS4xXsDPluUVL4aWhj3Wa1p6NbFBr7Dqxise4k0HVy+Fh0SvI
         HsPoN3ZCpID3XE1qcnufMMw5PwXZievMCM3eEalP/PCFvoq45yRqgUB3fi9TT3SUQUwn
         yMvRjftdD//Qqism94VlAmjsDcZTaFQdKYZYz7Q1S7+nszjIzBniNWmG0myWVzn08cna
         QxGQ==
X-Gm-Message-State: AOAM530zpYnava5FDLuLXrZxN27MsTVZx+g8AAizf25EmRjWhbaQAss/
        I1Le2+68C4VplfxwfUlhImEYVl/3qlunwQ==
X-Google-Smtp-Source: ABdhPJxOl9/7WzKIWOyEWXlwozmClPTfR7YGpoRlSDC00W0KLvRODwhCKeBhnaXXhi6/XbkebyxQZA==
X-Received: by 2002:a05:6512:b81:: with SMTP id b1mr23370847lfv.301.1632733904548;
        Mon, 27 Sep 2021 02:11:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d16sm1526937lfg.138.2021.09.27.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:11:43 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4D17910306C; Mon, 27 Sep 2021 12:11:43 +0300 (+03)
Date:   Mon, 27 Sep 2021 12:11:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/8] mm/madvise: remove unnecessary check on
 madvise_dontneed_free()
Message-ID: <20210927091143.tn6ediykqycu6rtu@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926161259.238054-3-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 09:12:53AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> madvise_dontneed_free() is called only from madvise_vma() and the
> behavior is always either MADV_FREE or MADV_DONTNEED. There is no need
> to check again in madvise_dontneed_free() if the behavior is any
> different.

So what. The check is free. Compiler should be clever enough to eliminate
the additional check. If there's a new MADV_DONTNEED flavour, the change
would have to be effectively reverted.

NAK.

-- 
 Kirill A. Shutemov
