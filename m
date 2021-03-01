Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC37329FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574651AbhCBDsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:48:33 -0500
Received: from ms.lwn.net ([45.79.88.28]:40948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244095AbhCAVXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:23:35 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D0AC22BA;
        Mon,  1 Mar 2021 21:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0AC22BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614633770; bh=VCRXVUkenSuHp0KioD8Z4ZPbBAR1shgvy7q8YJn2q0k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AWsbF5Zp6mmMuhNJAGxIO6wrmTXjReoBnZFoUWdYSjhr7Z/lRGTR1VHPc70H1BzGZ
         sSLc+ZvLZ9vfWrkOFqm5wUZtB+v062cHD0JC1omOaeZHMngCEE2dc3yzxwNFybL/Ne
         TytJlgh28uO/XMZg3WCIKdyHedKM559wqLswH7Y5aZGe8F6R2A+llWrPzQ7kzPBwp/
         BSbbpkUc+MuQEd5zt24S2op5lcDt+RekHRapzsECCwgFoqvqp2n9MmmScEiwJRAm+9
         fRA96d+s0MSAe0WkEQGwlGdtfgoFI8JEhCexcRbq/BNYCch6NJehO8YE7RFtzaQQnU
         frm6rX7C+wcuQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, joe@perches.com,
        mchehab@kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v8 0/3] checkpatch: add verbose mode
In-Reply-To: <20210226093827.12700-1-dwaipayanray1@gmail.com>
References: <20210226093827.12700-1-dwaipayanray1@gmail.com>
Date:   Mon, 01 Mar 2021 14:22:49 -0700
Message-ID: <87tupu36xi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> Add a new verbose mode to checkpatch. The verbose test
> descriptions are read from the new checkpatch documentation
> file at `Documentation/dev-tools/checkpatch.rst`, which
> is also added by this series.

So I can certainly take the doc change, as requested.  Remind me,
though...should I apply the whole set, or will the checkpatch changes go
via another path?

Thanks,

jon
