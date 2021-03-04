Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7432D7B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhCDQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:24:31 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42898 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237033AbhCDQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:09 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124GC7c1032630;
        Thu, 4 Mar 2021 17:23:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Ri/e9dhMljW8NcmcsKW3P/a5WcwXhSJ/6sOg02kFwtA=;
 b=toMUEvr4/w7gfYzkIlfrvMY8MOLrccvwAYpxZflp8boF4Ae9PSKjz+spcCxEKd5hUzZK
 BHpE8g4IXVaOhx114J1z9EtOjAG2gZm0CsKQCLAsvn/esUeHon/Dq4AIOhxTmYYHOvNA
 /WHagZNCF8HxZLshGW2LXQokFv8h/xss9UnfIpATSvoPIsloNEIOQKw00d38cvxGFlo0
 i15LiSfNpepEg25Qhr7zY1+VMTCdv90ZQ7fudqmsxzVUMuMDKsee279e+qG8Tb2OXtb3
 cyHq6i7KGfdmfqrtvpjSwSWE2sm2SRN+MC/Y0a9wSjFRlNW5S3OJeMFBN8kieye5XUtG Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yf9qgkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 17:23:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 674BE100038;
        Thu,  4 Mar 2021 17:23:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A87C20741B;
        Thu,  4 Mar 2021 17:23:19 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar 2021 17:23:18
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 10/13] serial: stm32: fix FIFO flush in startup and set_termios
Date:   Thu, 4 Mar 2021 17:23:05 +0100
Message-ID: <20210304162308.8984-11-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304162308.8984-1-erwan.leray@foss.st.com>
References: <20210304162308.8984-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fifo flush set USART_RQR register by calling stm32_usart_set_bits
routine (Read/Modify/Write). USART_RQR register is a write only
register. So, read before write isn't correct / relevant to flush
the FIFOs.
Replace stm32_usart_set_bits call by writel_relaxed.

Fixes: 84872dc448fe ("serial: stm32: add RX and TX FIFO flush")
Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2bdd04a47f91..183c76ddb165 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -657,7 +657,7 @@ static int stm32_usart_startup(struct uart_port *port)
 
 	/* RX FIFO Flush */
 	if (ofs->rqr != UNDEF_REG)
-		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
+		writel_relaxed(USART_RQR_RXFRQ, port->membase + ofs->rqr);
 
 	/* RX enabling */
 	val = stm32_port->cr1_irq | USART_CR1_RE | BIT(cfg->uart_enable_bit);
@@ -762,8 +762,8 @@ static void stm32_usart_set_termios(struct uart_port *port,
 
 	/* flush RX & TX FIFO */
 	if (ofs->rqr != UNDEF_REG)
-		stm32_usart_set_bits(port, ofs->rqr,
-				     USART_RQR_TXFRQ | USART_RQR_RXFRQ);
+		writel_relaxed(USART_RQR_TXFRQ | USART_RQR_RXFRQ,
+			       port->membase + ofs->rqr);
 
 	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
-- 
2.17.1

