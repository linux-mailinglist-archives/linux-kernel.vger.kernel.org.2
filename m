Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8042510E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbhJGK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:29:48 -0400
Received: from mail-4022.proton.ch ([185.70.40.22]:40661 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhJGK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:29:47 -0400
Date:   Thu, 07 Oct 2021 10:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1633602472;
        bh=SCRdqYu/X+JlKwPLq1M2s6KsWP3afb1Fv8d1g4YI73I=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=x8dUwwWILkAU4wRcL4uYHIN8jZr+f92xwSq0VH95fhJ0bo1z3w4wxSfhGCkTmwc5m
         2rasuO02jhl6U6S7ZBF1h8YwPhoKAZpYJIXEzoFZ3rpMvEj4MAOYfc2jiRGRYgK9+e
         CHHc57rNn06TLGCBfZ6U4bSdCNB32KvHr9OHFiKBN4yYBGwKOWK3tG/Qbx/e9SnWFS
         TeGXKKJCJqqIt1Y+XUWi2Jx4IAn4l4HPc9q3C219litfkAfX/WtL9PZyfmV6CCowsq
         h4o//ylnaC/3AoyNkK8zWA8N+FAPL7hjub93DLE03cc2mgivXEmX1SV9sIWtOu8UTZ
         1JyA1E/rTFNbA==
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3] drm/plane-helper: fix uninitialized variable reference
Message-ID: <8jznM1zShVceOF2IvoMF0A6tKwHeua93m1l2uVxmMy355OlLrGMKcf73CvXqtLtda8KfVxoeGW74yIjI-9N20g3pgzb41Eb11Ly2vSQf5Z8=@emersion.fr>
In-Reply-To: <20211007063706.305984-1-alex_y_xu@yahoo.ca>
References: <20211007063706.305984-1-alex_y_xu.ref@yahoo.ca> <20211007063706.305984-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed, thanks!
