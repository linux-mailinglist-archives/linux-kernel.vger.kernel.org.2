Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E74047D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhIIJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:35:59 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:30581 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:35:56 -0400
Date:   Thu, 09 Sep 2021 09:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1631180086;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Zr6kw1t11YRwFlGZuurT+Y1rxqpUZisEEzTRiOrt6fn5Wou1fxNh36NGhwK6qpskk
         Sq0N1SjYFW1X7UHU/oa6wFAmKXQs3VGYYg9V2XQfQOjLCL8CGCYGGDBixqBKnMYDlw
         6PS4eaNOq7MH/xPMjoAB5Mpq7QZq5/UsBV2EV5ujVKQfUovq3PI9shu+pkNexU5Lti
         ov4tOG2GzyGcJ1/mE8L5bofB8MxWponmLLv3OllUtcRv1WIBzdY0vH4RbnVvqRLidp
         xE7KZm5pcOVE6YsyLWaob0W7hkM2g7crWVFf0ZFa5QzZgimDU31jM8/exdBd6lLJYU
         M/bamJd2BPUkA==
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2] drm/plane-helper: fix uninitialized variable reference
Message-ID: <BPJHmAoRYS9O-kvBP6sW8fAfyOEVZuL52c2JzwBDkLNPgIif_8YujX5jmluOmm-2ESW4A1lwqnfdCo4-QMYeryio1P4pkbfn7_TkhGlYi70=@emersion.fr>
In-Reply-To: <20210909013247.32743-1-alex_y_xu@yahoo.ca>
References: <YTkCQCPwZPbhMfeF@phenom.ffwll.local> <20210909013247.32743-1-alex_y_xu@yahoo.ca>
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

Reviewed-by: Simon Ser <contact@emersion.fr>


