Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF7397A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFASyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFASyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:54:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52EC061574;
        Tue,  1 Jun 2021 11:53:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EEB432CD;
        Tue,  1 Jun 2021 18:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EEB432CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622573582; bh=eQU1zLIMICap5wSz2gX4aQO5nbrAvf5AdBldQ7YTuJY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iNlgRfdsGUvcl0jhHQD6xbxG3zkz+SiJ8lIbL2GxWPvNAwjNomSlxhWMYZKFz/Cuh
         EeKV9AgzMVwmolWXrecK37dAgw4TkN/MNmzwy+Njmax6rYGInzWbldzIN8LkePfxU7
         7JJSJXynWFJe8t409B1inyuwwl/vpUiN5KtixEGEsm83QSmaM7uZHt7apeXOzLIPRD
         IItSopuKR2Vi7xWRqAda9pKCb4GiqDSytsfbL/ZAeQTec9dB6K3ezACfLVkVhXBArU
         LSZ2Cr0CMWT8JAYU5KlI67ziKkHJT60e06W+v3hqmCc7OcjNuP/wKrbP8tGjnx5ZML
         /K+CN0v6hRE1A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, samuel.thibault@ens-lyon.org,
        grandmaster@al2klimov.de, rdunlap@infradead.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
In-Reply-To: <20210531215737.8431-1-igormtorrente@gmail.com>
References: <20210531215737.8431-1-igormtorrente@gmail.com>
Date:   Tue, 01 Jun 2021 12:53:01 -0600
Message-ID: <875yyxbenm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Matheus Andrade Torrente <igormtorrente@gmail.com> writes:

> Modify some parts of the text and add the necessary formatting to leverage
> the rst features. Including links, code-blocks, bullet lists, etc.
>
> Also, adds a table of contents at the beginning and a section to the
> license.
>
> This change helps integrate this documentation to the rest of the rst
> documentation.
>
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

Thanks for doing this work - I'm definitely in favor of it, and if the
RST format works for the intended readers, we want it.

Do please follow through on Jani's comments.

I am concerned about one thing, though: the licensing of this document
is not GPL-compatible, which means we can't build it into the rest of
the docs.  It looks like it entered Documentation/ from staging, through
Greg's [added to CC] tree.  Greg, were you aware of this licensing when
you added this document?

What are the chances that we can get the authors to agree on a change to
a GPL-compatible license for this file?

Thanks,

jon
