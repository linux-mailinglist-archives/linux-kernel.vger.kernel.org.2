Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6B31EE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhBRSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:22:55 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:60800 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhBRPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:55:28 -0500
Date:   Thu, 18 Feb 2021 15:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613663672;
        bh=0F5bOJE9FkJO0yoXlkGBbjh+9YZ0Gztvth6EcfpFias=;
        h=Date:To:From:Reply-To:Subject:From;
        b=xToeaOB2U/mlybdMyOSkp+EYUaDBraYLq5ouCp0abk8yIVvGn6zF08eO7YDzT3Xai
         wyRfhY9tSr8gQPsu/Jm+hoYN23h5aiphoDVPwcinGq3rEpcqWc3f6gGFfp9ursSYjw
         HvHF9u+ckaX+QW/uwhJi5Hy7qcO84qsj1QfXHMy4=
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Kurt Manucredo <fuzzybritches@protonmail.com>
Reply-To: Kurt Manucredo <fuzzybritches@protonmail.com>
Subject: [PATCH] fix comparisons - put constant on right side- eudyptula
Message-ID: <20210218155422.7-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear linux kernel developers,

for my eudyptula challenge it is required of me to fix a coding style
issue in the staging area in linux-next. I am aware that it is in
general frowned upon when submitting these sorts of patches. However, to
finish my 10th challenge I was tasked to do exactly that. So I ask you
kindly to pull this patch if possible.

Thank you for your time,

kind regards



