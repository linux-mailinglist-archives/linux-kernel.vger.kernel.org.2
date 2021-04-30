Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0936FC78
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhD3OcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:32:04 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:49527 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhD3OcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:32:03 -0400
Date:   Fri, 30 Apr 2021 14:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1619793071;
        bh=M/iHqicJNA39pyXoMmPq3hC9gdjdt8s3Boy91m6KHm8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dhinYSfNarUJDsNnzBp9083R8RJ9YfIpbPdIQ6a0dPEtFActPGm20xP0d4+G7Dl1C
         B1Yf1jIW8FqT3A63zujg8eDRFCBZklATK+QJZdxNzIBF8a7aOg8Bs7Y7d2/eSetaN5
         Lt1vHFhAgnvgdSxkmotVYolPmMjIAxEhRjTf8SPOkPzYe//aLcRQ4aolDCfjdvumGl
         of8Ls1PY78t/SgFPyduMb4ND3ltngKX8HGUTLfUa/I2h5n/ChHZkWo+Fztw3+6s9zU
         D3993gXMPTGmwOsD44AjoTxHm/gsMnl0eQV7QHa+ysFUckrVEfOXvi+8o+viJ7efd6
         ZtqZ1vWs97BtQ==
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH 02/43] staging: rlt8723bs: remove if-else blocks left empty by ODM_RT_TRACE deletion
Message-ID: <20210430143100.jfdaitqlqaclmajp@bryanbrattlof.com>
In-Reply-To: <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com> <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com>
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

On Fri, Apr 30, 2021 at 09:43:20AM +0200, Fabio Aiuto wrote:
>remove if-else blocks left empty by ODM_RT_TRACE deletion.
>remove unused variables to suppress compiler warnings.
>
>Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>

Hi Fabio!

I just wanted to point out a spelling mistake in the title 'rlt8723bs'
in the off chance you submit a v2.

Way to go switching this over to netdev btw.
--
~Bryan

