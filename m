Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDE441AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhKALaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:30:23 -0400
Received: from mta-13-4.privateemail.com ([198.54.127.109]:58638 "EHLO
        MTA-13-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhKALaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:30:22 -0400
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 58E4218000A3;
        Mon,  1 Nov 2021 07:27:48 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.245])
        by mta-13.privateemail.com (Postfix) with ESMTPA id C6EE318000A0;
        Mon,  1 Nov 2021 07:27:47 -0400 (EDT)
Date:   Mon, 01 Nov 2021 07:27:41 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Question regarding register_sysctl_table()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <565W1R.3MI0EBO1N6WW@effective-light.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Luis,

I recently came across [1], and was wondering why it is desirable to 
unexport
register_sysctl_table()?

1. https://kernelnewbies.org/KernelProjects/proc


