Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCF4355DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJTWb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhJTWb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:31:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36716056B;
        Wed, 20 Oct 2021 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634768952;
        bh=jRHi18PfO4NBozNbrNBvNRggK2ZyxPV2M2RhSxhsXMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TEnlDxKO4pPNEPA8gMkZMBGcRHi0pPKo1l5f/n3ejSwPQs+QQF0oFWcxHlefY//GH
         rcg/twsI8uuY/cEonHRFx/BIrlhZwfaRvfZ4tVriO9cpl1MDkAnQD2HW/bPFKh3Fpd
         xuNvX08dOoJlR76MvWo/YNj6TrqKypUwXxEFUdmo=
Date:   Wed, 20 Oct 2021 15:29:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        nicholas.tang@mediatek.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] kasan: add kasan mode messages when kasan init
Message-Id: <20211020152909.2ea34f8f0c0d70d8b245b234@linux-foundation.org>
In-Reply-To: <CANpmjNMk-2pfBjD3ak9hto+xAFExuG+Pc-_vQRa6DSS=9-=WUg@mail.gmail.com>
References: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
        <CANpmjNMk-2pfBjD3ak9hto+xAFExuG+Pc-_vQRa6DSS=9-=WUg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:58:26 +0200 Marco Elver <elver@google.com> wrote:

> On Wed, 20 Oct 2021 at 11:48, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
> >
> > There are multiple kasan modes. It makes sense that we add some messages
> > to know which kasan mode is when booting up. see [1].
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Thank you.
> 
> Because this is rebased on the changes in the arm64 tree, and also
> touches arch/arm64, it probably has to go through the arm64 tree.

That would be OK, as long as it doesn't also have dependencies on
pending changes elsewhere in the -mm tree.

To solve both potential problems, I've queued it in -mm's
post-linux-next section, so it gets sent to Linus after both -mm and
arm have merged up.

