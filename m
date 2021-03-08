Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C633092F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCHILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:11:24 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:32776 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhCHILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:11:10 -0500
Date:   Mon, 08 Mar 2021 08:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1615191068;
        bh=JgpnMwHv+56Z6pM6R18747j5rGXmQCVa51r6ebshfRk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sfNjOLTVrPdS3IcCfZiOSwBb+EXq+wran9dJbq2YryRlmjvvpb+UCAj28EFCV/cNI
         pt248GoiPdF+tBNLuykiujJySmaldkm6r6v63ajlOtLXurCWvdxlFVmMeja9aLgit4
         rE4vEmw1T1LiEVFjHewVMskmSH+2CJdHNKB5cPU0T4tq2QNEl9K94p9qka5NifYybL
         IErLQfwMwPWMuM5SQnn8XPwN/T4NkSoJZfT/FQa1H1IJhmOQInbnzrXvK56+DgGZvT
         vdPzrwl3+zwQz3aUwrkhK3fGHGzHUDC6bRgB4q8XgaonL5SR1kdtRR7C+EY3SFsB+U
         rHf0fFMiilqRQ==
To:     Jianhui Zhao <zhaojh329@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tzimmermann@suse.de
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] docs: gpu: fix typo
Message-ID: <hKfmUsjpKZHUiRQ8FD_ZeOFKn1zaa5b5x2rmlF3iWLw4m3aPtg75LyDiFgkeNR5-DlgOzV0Flw6ARPrqJxFGdnHQbVXVyzEV9sHk1J50qAA=@emersion.fr>
In-Reply-To: <20210308064250.3681707-1-zhaojh329@gmail.com>
References: <20210308064250.3681707-1-zhaojh329@gmail.com>
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

R-b me. Pushed, thanks!
