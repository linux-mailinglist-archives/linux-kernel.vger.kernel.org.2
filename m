Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA333C586
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhCOSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhCOSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:25:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E088DC06174A;
        Mon, 15 Mar 2021 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YOzHIQnZESj9u9Lf8Xh0DaOSeHoTZv9i/s5lCLwFUCY=; b=3a7NarveVyEfU5Ljk8M4lHhht2
        pdeY46C/iK/svlBQ43+2RybyCP+P4yhJcXyVFIiDl9zqgSDKJ3OVfQq8t3zjVdrpq1XJAtg2PWfLr
        k7Ax1MaEancZPBrz3TSoZY2CEdnzVo5oYEoD2bVwd9PHuWQeUDXImGXbE+fg1oIs+hEXi91zCqqu7
        F8jirYkqyinZgLCQciZ11jAu0K9MoDz7SvYeRrFRKRGk7PHP4O8oR3cGuoRaz2g7qeZIVBOJyouZ8
        unCABByrTGxXWutPW+eLex5tQiJnGmibTl3FJKZD8Xqq3GBRThZsMVeY7YgJ7cIUwGWFcDGXoeH0B
        0ss6kvEg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLrtr-001L33-Ot; Mon, 15 Mar 2021 18:25:10 +0000
Subject: Re: [PATCH v3] docs: usbip: Fix major fields and descriptions in
 protocol
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?TcOhcnRvbiBOw6ltZXRo?= <nm127@freemail.hu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Alexandre Demers <alexandre.f.demers@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        usbip-devel@lists.sourceforge.net
References: <YE6/HQoxkraowTI7@Sun> <YE78SRefRe1trldP@Sun>
 <YE8Oan2BmSuKR4/p@kroah.com> <YE8dakf3nIn0jJew@Sun>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <40351ed6-2907-3966-e69a-a564173b3682@infradead.org>
Date:   Mon, 15 Mar 2021 11:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE8dakf3nIn0jJew@Sun>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Some comments inline.


On 3/15/21 1:40 AM, Hongren Zheng (Zenithal) wrote:
> The old document for usbip protocol is misleading and hard to read:
>   * Some fields in header are incorrect
>   * Explanation of some fields are unclear or even wrong
>   * Padding of header (namely all headers have the same length) is
>     not explicitly point out, which is crucial for stream protocol like
>     TCP
> 
> These fixes are made through reading usbip kernel drivers and userland
> codes. Also I have implemented one usbip server.
> 
> Major changes:
> 
> PATCH v2:
> 
> PATCH v3:
> 
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Hongren Zheng (Zenithal) <i@zenithal.me>
> ---
>  Documentation/usb/usbip_protocol.rst | 288 ++++++++++++++-------------
>  1 file changed, 155 insertions(+), 133 deletions(-)
> 
> diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
> index 988c832166cd..ed423cdda236 100644
> --- a/Documentation/usb/usbip_protocol.rst
> +++ b/Documentation/usb/usbip_protocol.rst

> @@ -254,65 +283,75 @@ OP_REP_IMPORT:
>  | 0x13E     | 1      |            | bNumInterfaces                                    |
>  +-----------+--------+------------+---------------------------------------------------+
>  
> -USBIP_CMD_SUBMIT:
> -	Submit an URB
> +The following four commands have a common basic header called
> +'usbip_header_basic', and their headers, called 'usbip_header' (before URB
> +payload), have the same length, therefore paddings are needed.
>  
> -+-----------+--------+------------+---------------------------------------------------+
> -| Offset    | Length | Value      | Description                                       |
> -+===========+========+============+===================================================+
> -| 0         | 4      | 0x00000001 | command: Submit an URB                            |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 4         | 4      |            | seqnum: the sequence number of the URB to submit  |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 8         | 4      |            | devid                                             |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0xC       | 4      |            | direction:                                        |
> -|           |        |            |                                                   |
> -|           |        |            |    - 0: USBIP_DIR_OUT                             |
> -|           |        |            |    - 1: USBIP_DIR_IN                              |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x10      | 4      |            | ep: endpoint number, possible values are: 0...15  |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x14      | 4      |            | transfer_flags: possible values depend on the     |
> -|           |        |            | URB transfer type, see below                      |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x18      | 4      |            | transfer_buffer_length                            |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x1C      | 4      |            | start_frame: specify the selected frame to        |
> -|           |        |            | transmit an ISO frame, ignored if URB_ISO_ASAP    |
> -|           |        |            | is specified at transfer_flags                    |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x20      | 4      |            | number_of_packets: number of ISO packets          |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x24      | 4      |            | interval: maximum time for the request on the     |
> -|           |        |            | server-side host controller                       |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
> -|           |        |            | zeros if not used                                 |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x30      |        |            | URB data. For ISO transfers the padding between   |
> -|           |        |            | each ISO packets is not transmitted.              |
> -+-----------+--------+------------+---------------------------------------------------+
> +usbip_header_basic:
>  
> ++-----------+--------+---------------------------------------------------+
> +| Offset    | Length | Description                                       |
> ++===========+========+===================================================+
> +| 0         | 4      | command                                           |
> ++-----------+--------+---------------------------------------------------+
> +| 4         | 4      | seqnum: sequential number that identifies requests|
> +|           |        | and corresponding responses;                      |
> +|           |        | incremented per connection                        |
> ++-----------+--------+---------------------------------------------------+
> +| 8         | 4      | devid: specifies a remote USB device uniquely     |
> +|           |        | instead of busnum and devnum;                     |
> +|           |        | for client (request), this value is               |
> +|           |        | ((busnum << 16) | devnum);                        |
> +|           |        | for server (response), this shall be set to 0     |
> ++-----------+--------+---------------------------------------------------+
> +| 0xC       | 4      | direction:                                        |
> +|           |        |                                                   |
> +|           |        |    - 0: USBIP_DIR_OUT                             |
> +|           |        |    - 1: USBIP_DIR_IN                              |
> +|           |        |                                                   |
> +|           |        | only used by client, for server this shall be 0   |
> ++-----------+--------+---------------------------------------------------+
> +| 0x10      | 4      | ep: endpoint number                               |
> +|           |        | only used by client, for server this shall be 0   |

This could use a ';' after the '0' above for better readability.

> +|           |        | for UNLINK, this shall be 0                       |
> ++-----------+--------+---------------------------------------------------+
>  
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | Allowed transfer_flags  | value      | control | interrupt | bulk     | isochronous |
> - +=========================+============+=========+===========+==========+=============+
> - | URB_SHORT_NOT_OK        | 0x00000001 | only in | only in   | only in  | no          |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_ISO_ASAP            | 0x00000002 | no      | no        | no       | yes         |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_NO_TRANSFER_DMA_MAP | 0x00000004 | yes     | yes       | yes      | yes         |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_ZERO_PACKET         | 0x00000040 | no      | no        | only out | no          |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_NO_INTERRUPT        | 0x00000080 | yes     | yes       | yes      | yes         |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_FREE_BUFFER         | 0x00000100 | yes     | yes       | yes      | yes         |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> - | URB_DIR_MASK            | 0x00000200 | yes     | yes       | yes      | yes         |
> - +-------------------------+------------+---------+-----------+----------+-------------+
> +USBIP_CMD_SUBMIT:
> +	Submit an URB
>  
> ++-----------+--------+---------------------------------------------------+
> +| Offset    | Length | Description                                       |
> ++===========+========+===================================================+
> +| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000001 |
> ++-----------+--------+---------------------------------------------------+
> +| 0x14      | 4      | transfer_flags: possible values depend on the     |
> +|           |        | URB transfer_flags,                               |
> +|           |        | but with URB_NO_TRANSFER_DMA_MAP masked           |
> ++-----------+--------+---------------------------------------------------+
> +| 0x18      | 4      | transfer_buffer_length:                           |
> +|           |        | use URB transfer_buffer_length                    |
> ++-----------+--------+---------------------------------------------------+
> +| 0x1C      | 4      | start_frame: use URB start_frame;                 |
> +|           |        | initial frame for ISO transfer                    |

                                                transfer;

> +|           |        | shall be set to 0 if not ISO transfer             |
> ++-----------+--------+---------------------------------------------------+
> +| 0x20      | 4      | number_of_packets: number of ISO packets          |

                                                           packets;

> +|           |        | shall be set to 0xffffffff if not ISO transfer    |
> ++-----------+--------+---------------------------------------------------+
> +| 0x24      | 4      | interval: maximum time for the request on the     |
> +|           |        | server-side host controller                       |
> ++-----------+--------+---------------------------------------------------+
> +| 0x28      | 8      | setup: data bytes for USB setup, filled with      |
> +|           |        | zeros if not used                                 |
> ++-----------+--------+---------------------------------------------------+
> +| 0x30      | n      | tranfer_buffer.                                   |
> +|           |        | If direction is USBIP_DIR_OUT then n equals       |
> +|           |        | transfer_buffer_length; otherwise n equals 0      |

                                                              equals 0.

> +|           |        | For ISO transfers the padding between each ISO    |
> +|           |        | between each ISO packets is not transmitted.      |
> ++-----------+--------+---------------------------------------------------+
> +| 0x30+n    | m      | iso_packet_descriptor                             |
> ++-----------+--------+---------------------------------------------------+
>  
>  USBIP_RET_SUBMIT:
>  	Reply for submitting an URB
> @@ -320,92 +359,75 @@ USBIP_RET_SUBMIT:
>  +-----------+--------+------------+---------------------------------------------------+
>  | Offset    | Length | Value      | Description                                       |
>  +===========+========+============+===================================================+
> -| 0         | 4      | 0x00000003 | command                                           |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 4         | 4      |            | seqnum: URB sequence number                       |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 8         | 4      |            | devid                                             |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0xC       | 4      |            | direction:                                        |
> -|           |        |            |                                                   |
> -|           |        |            |    - 0: USBIP_DIR_OUT                             |
> -|           |        |            |    - 1: USBIP_DIR_IN                              |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x10      | 4      |            | ep: endpoint number                               |
> +| 0         | 20     |            | usbip_header_basic, 'command' shall be 0x00000003 |
>  +-----------+--------+------------+---------------------------------------------------+
>  | 0x14      | 4      |            | status: zero for successful URB transaction,      |
>  |           |        |            | otherwise some kind of error happened.            |
>  +-----------+--------+------------+---------------------------------------------------+
>  | 0x18      | 4      | n          | actual_length: number of URB data bytes           |

                                                                         bytes;

> +|           |        |            | use URB actual_length                             |
>  +-----------+--------+------------+---------------------------------------------------+
> -| 0x1C      | 4      |            | start_frame: for an ISO frame the actually        |
> -|           |        |            | selected frame for transmit.                      |
> +| 0x1C      | 4      |            | start_frame: use URB start_frame;                 |
> +|           |        |            | initial frame for ISO transfer                    |

                                                             transfer;

> +|           |        |            | shall be set to 0 if not ISO transfer             |
>  +-----------+--------+------------+---------------------------------------------------+
> -| 0x20      | 4      |            | number_of_packets                                 |
> +| 0x20      | 4      |            | number_of_packets: number of ISO packets          |

                                                                        packets;

> +|           |        |            | shall be set to 0xffffffff if not ISO transfer    |
>  +-----------+--------+------------+---------------------------------------------------+
>  | 0x24      | 4      |            | error_count                                       |
>  +-----------+--------+------------+---------------------------------------------------+
> -| 0x28      | 8      |            | setup: data bytes for USB setup, filled with      |
> -|           |        |            | zeros if not used                                 |

                                                    used;

> +| 0x28      | 8      |            | padding, shall be set to 0                        |
>  +-----------+--------+------------+---------------------------------------------------+
> -| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
> +| 0x30      | n      |            | tranfer_buffer.                                   |

                                       transfer_buffer.

> +|           |        |            | If direction is USBIP_DIR_OUT then n equals       |
> +|           |        |            | transfer_buffer_length; otherwise n equals 0      |

                                                                           equals 0.

> +|           |        |            | For ISO transfers the padding between each ISO    |
>  |           |        |            | between each ISO packets is not transmitted.      |
>  +-----------+--------+------------+---------------------------------------------------+
> +| 0x30+n    | m      |            | iso_packet_descriptor                             |
> ++-----------+--------+------------+---------------------------------------------------+
>  
>  USBIP_CMD_UNLINK:
>  	Unlink an URB
>  
> -+-----------+--------+------------+---------------------------------------------------+
> -| Offset    | Length | Value      | Description                                       |
> -+===========+========+============+===================================================+
> -| 0         | 4      | 0x00000002 | command: URB unlink command                       |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 4         | 4      |            | seqnum: URB sequence number to unlink:            |
> -|           |        |            |                                                   |
> -|           |        |            | FIXME:                                            |
> -|           |        |            |    is this so?                                    |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 8         | 4      |            | devid                                             |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0xC       | 4      |            | direction:                                        |
> -|           |        |            |                                                   |
> -|           |        |            |    - 0: USBIP_DIR_OUT                             |
> -|           |        |            |    - 1: USBIP_DIR_IN                              |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x10      | 4      |            | ep: endpoint number: zero                         |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x14      | 4      |            | seqnum: the URB sequence number given previously  |
> -|           |        |            | at USBIP_CMD_SUBMIT.seqnum field                  |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
> -|           |        |            | between each ISO packets is not transmitted.      |
> -+-----------+--------+------------+---------------------------------------------------+
> ++-----------+--------+---------------------------------------------------+
> +| Offset    | Length | Description                                       |
> ++===========+========+===================================================+
> +| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000002 |
> ++-----------+--------+---------------------------------------------------+
> +| 0x14      | 4      | unlink_seqnum, of the SUBMIT request to unlink    |
> ++-----------+--------+---------------------------------------------------+
> +| 0x18      | 24     | padding, shall be set to 0                        |
> ++-----------+--------+---------------------------------------------------+
>  
>  USBIP_RET_UNLINK:
>  	Reply for URB unlink
>  
> -+-----------+--------+------------+---------------------------------------------------+
> -| Offset    | Length | Value      | Description                                       |
> -+===========+========+============+===================================================+
> -| 0         | 4      | 0x00000004 | command: reply for the URB unlink command         |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 4         | 4      |            | seqnum: the unlinked URB sequence number          |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 8         | 4      |            | devid                                             |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0xC       | 4      |            | direction:                                        |
> -|           |        |            |                                                   |
> -|           |        |            |    - 0: USBIP_DIR_OUT                             |
> -|           |        |            |    - 1: USBIP_DIR_IN                              |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x10      | 4      |            | ep: endpoint number                               |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x14      | 4      |            | status: This is the value contained in the        |
> -|           |        |            | urb->status in the URB completition handler.      |

                                                              completion

> -|           |        |            |                                                   |
> -|           |        |            | FIXME:                                            |
> -|           |        |            |      a better explanation needed.                 |
> -+-----------+--------+------------+---------------------------------------------------+
> -| 0x30      | n      |            | URB data bytes. For ISO transfers the padding     |
> -|           |        |            | between each ISO packets is not transmitted.      |
> -+-----------+--------+------------+---------------------------------------------------+
> ++-----------+--------+---------------------------------------------------+
> +| Offset    | Length | Description                                       |
> ++===========+========+===================================================+
> +| 0         | 20     | usbip_header_basic, 'command' shall be 0x00000004 |
> ++-----------+--------+---------------------------------------------------+
> +| 0x14      | 4      | status: This is similar to that status of         |

                                                  to the status of

> +|           |        | USBIP_RET_SUBMIT (share the same memory offset)   |

                                                                  offset).

> +|           |        | When UNLINK is successful, status is -ECONNRESET; |
> +|           |        | when USBIP_CMD_UNLINK is after USBIP_RET_SUBMIT   |
> +|           |        | status is 0                                       |> ++-----------+--------+---------------------------------------------------+
> +| 0x18      | 24     | padding, shall be set to 0                        |
> ++-----------+--------+---------------------------------------------------+
> +
> +EXAMPLE
> +=======



HTH.
-- 
~Randy

