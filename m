Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46BA3A2BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFJMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:48:08 -0400
Received: from aposti.net ([89.234.176.197]:54484 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFJMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:48:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] iio: Add "extended_name" attribute
Date:   Thu, 10 Jun 2021 13:45:54 +0100
Message-Id: <20210610124556.34507-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Here's a small change to address an issue I've been facing since the
beginning in libiio, namely that the IIO tree in sysfs is not easily
parsable (read more about it in patch #2's summary).

Any feedback welcome.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Support removing extended name in attribute filename
  iio: core: Add "extended_name" attribute to all channels

 drivers/iio/iio_core.h            |  3 +-
 drivers/iio/industrialio-buffer.c | 12 +++--
 drivers/iio/industrialio-core.c   | 73 ++++++++++++++++++++++++++-----
 drivers/iio/industrialio-event.c  |  3 +-
 4 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.30.2

